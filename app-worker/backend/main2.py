# main.py
from fastapi import FastAPI, Depends, HTTPException, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from db import SessionLocal
from models import Product
import os
import speech_recognition as sr
import filter
from pydub import AudioSegment

app = FastAPI()
# Configura los orígenes permitidos
origins = [
    "http://localhost",
    "http://localhost:8000",
    "http://127.0.0.1:8000",
    "http://localhost:3000",
    "http://localhost:8080",
    "http://127.0.0.1:3000",
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



@app.post("/audio-to-response/")
async def audio_to_response(file: UploadFile = File(...)):
    """
    Recibe un archivo de audio en formato .mp3 y lo convierte a texto.
    """
    try:
        # Leer el archivo de audio cargado
        audio_data = await file.read()
        if not audio_data:
            raise HTTPException(status_code=400, detail="No se proporcionó un archivo válido.")

        print(f"Archivo de audio cargado con {len(audio_data)} bytes.")

        # Guardar el archivo .mp3 temporalmente
        temp_mp3_path = "temp_audio.mp3"
        with open(temp_mp3_path, "wb") as f:
            f.write(audio_data)

        # Convertir .mp3 a .wav usando pydub
        temp_wav_path = "temp_audio.wav"
        try:
            audio = AudioSegment.from_mp3(temp_mp3_path)
            audio.export(temp_wav_path, format="wav")
        except Exception as e:
            raise HTTPException(status_code=400, detail=f"Error al convertir el audio a .wav: {e}")

        # Inicializar el reconocedor de voz
        recognizer = sr.Recognizer()

        # Convertir el audio a texto usando Google Speech Recognition
        try:
            with sr.AudioFile(temp_wav_path) as source:
                audio = recognizer.record(source)
                text = recognizer.recognize_google(audio, language="es-ES")
            response = {
                "answer": text,
                "response": f"Audio procesado correctamente con {len(text)} caracteres."
            }
        except Exception as e:
            raise HTTPException(status_code=400, detail=f"Error procesando audio con Google Speech Recognition: {e}")
        finally:
            # Eliminar los archivos temporales
            os.remove(temp_mp3_path)
            os.remove(temp_wav_path)

        return response

    except Exception as general_exception:
        # Captura todas las excepciones y devuelve un mensaje de error claro
        raise HTTPException(status_code=400, detail=f"Error general: {general_exception}")
    