# import requests
# import os

# # Ruta completa al archivo de audio que se desea enviar
# audio_path = "/home/git/Ishtar/app-worker/backend/output.wav"

# # Verificar que el archivo existe
# if not os.path.isfile(audio_path):
#     print(f"El archivo {audio_path} no existe.")
# else:
#     # URL del endpoint
#     url = "http://0.0.0.0:8000/audio-to-response/"

#     # Abrir el archivo y enviarlo mediante una solicitud POST
#     with open(audio_path, "rb") as audio_file:
#         files = {"file": audio_file}
#         response = requests.post(url, files=files)

#     # Mostrar la respuesta
#     if response.status_code == 200:
#         print(response.json())
#     else:
#         print(f"Error: {response.status_code}, {response.text}")
import os

csv_training_path = "/home/git/Ishtar/app-worker/backend/process-audio/data_solc.csv"

if not os.path.exists(csv_training_path):
    raise FileNotFoundError(f"El archivo CSV no se encuentra en {csv_training_path}")

filter.train_model(csv_training_path)
