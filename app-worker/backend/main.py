# main.py
from fastapi import FastAPI, Depends, HTTPException, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from db import SessionLocal
from models import Product
import os
import speech_recognition as sr
import whisper
from filter import main as filternpl
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

app = FastAPI()
# Configura los orígenes permitidos
origins = [
    "http://localhost",
    "http://localhost:8000",
    "http://127.0.0.1:8000",
    "http://localhost:3000",
    "http://localhost:8080",
    "http://127.0.0.1:3000",
    "http://127.0.0.1:5173",
    "http://localhost:5173",
    # Agrega aquí otros orígenes permitidos según sea necesario
]

# Añade el middleware de CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  # Permitir solo los orígenes especificados
    allow_credentials=True,
    allow_methods=["*"],  # Permitir todos los métodos (GET, POST, etc.)
    allow_headers=["*"],  # Permitir todos los encabezados
)

@app.get("/")
def read_root():
    return {"message": "Hello World"}

# Función para obtener una instancia de la base de datos
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Endpoint para obtener una lista de productos
@app.get("/products/")
def read_products(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    products = db.query(Product).offset(skip).limit(limit).all()
    return products

# Endpoint para obtener un producto específico
@app.get("/products/{product_id}")
def read_product(product_id: int, db: Session = Depends(get_db)):
    product = db.query(Product).filter(Product.id == product_id).first()
    if product is None:
        return {"error": "Product not found"}
    return product


# Entrenar el modelo al inicio de la aplicación
# Asegúrate de proporcionar la ruta correcta al archivo CSV de entrenamiento
# csv_training_path = "process-audio/data_solc.csv"
# filter.train_model(csv_training_path)
 
@app.post("/audio-to-response/")
async def audio_to_response(file: UploadFile = File(...)):
    """
    Recibe un archivo de audio y lo convierte a texto usando Whisper.
    """
    # Leer el archivo de audio cargado
    audio_data = await file.read()
    if not audio_data:
        raise HTTPException(status_code=400, detail="No se proporcionó un archivo válido.")

    # Guardar temporalmente el archivo como .wav
    temp_audio_path = "temp_audio.wav"
    with open(temp_audio_path, "wb") as f:
        f.write(audio_data)

    # Transcribir el audio usando Whisper
    try:
        model = whisper.load_model("base")  # Cargar el modelo Whisper
        result = model.transcribe(temp_audio_path)  # Transcribir el audio desde el archivo .wav

        response = {
            "answer": result["text"],
            "response": f"Texto procesado correctamente: {result['text']}"
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error procesando audio: {e}")
    finally:
        # Eliminar el archivo temporal
        os.remove(temp_audio_path)

    return response



@app.get("/option/")
async def audio_to_response(answer: str):
    """
    Recibe un archivo de audio, lo convierte a texto y predice una etiqueta usando filter.
    """

        # Ruta al archivo CSV para entrenamiento
    

    # Leer el archivo de audio cargado
    try:
        
        csv_training_path = "data.csv"
        

        # Entrena el modelo al iniciar la aplicación
        optiontext=filternpl(csv_training_path,answer)
        
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error al procesar texto y reducirlo a opciones: {e}")

    
    
    try:
        

        response = {
            "answer": optiontext,
            "response": f"Texto procesado correctamente: {optiontext}"
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error procesando audio con Whisper: {e}")
    

    return response


@app.get("/buy")
def get_product(answer: str, db: Session = Depends(get_db)):
    # Obtenemos todos los nombres de productos
    products = db.query(Product).all()

    if not products:
        raise HTTPException(status_code=404, detail="No products in database")

    product_names = [product.name for product in products]
    print(product_names)
    
    # Aplicamos TF-IDF
    tfidf_vectorizer = TfidfVectorizer().fit_transform(product_names)
    answer_vector = TfidfVectorizer().fit(product_names).transform([answer])
    
    # Calculamos la similitud coseno
    similarity_scores = cosine_similarity(answer_vector, tfidf_vectorizer).flatten()
    
    # Ordenamos los productos por el puntaje de similitud
    sorted_indices = similarity_scores.argsort()[::-1]
    matched_products = [products[i] for i in sorted_indices if similarity_scores[i] > 0]
    
    if not matched_products:
        raise HTTPException(status_code=404, detail="No products found")
    
    return [{"id": product.id, "name": product.name} for product in matched_products]
# # Endpoint para procesar un archivo de audio y convertirlo a texto
# @app.post("/audio-to-response/")
# async def audio_to_response(file: UploadFile = File(...)):
#     # Leer el archivo de audio cargado
#     audio_data = await file.read()


#     print(f"Archivo de audio cargado con {len(audio_data)} bytes.") # Mostrar el tamaño del archivo
#     # Guardar temporalmente el archivo
#     temp_audio_path = "temp_audio.wav"
#     with open(temp_audio_path, "wb") as f:
#         f.write(audio_data)

#     # Inicializar el reconocedor de voz
#     recognizer = sr.Recognizer()

#     # Convertir el audio a texto usando Google Speech Recognition
#     try:
#         with sr.AudioFile(temp_audio_path) as source:
#             audio = recognizer.record(source)
#             text = recognizer.recognize_google(audio, language="es-ES")
#         response = {
#             "answer": text,
#             "response": f"Audio procesado correctamente con {len(text)} caracteres."
#         }
#     except Exception as e:
#         raise HTTPException(status_code=400, detail=f"Error procesando audio: {e}")
#     finally:
#         # Eliminar el archivo temporal
#         os.remove(temp_audio_path)

#     return response
