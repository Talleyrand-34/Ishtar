import whisper

model = whisper.load_model("base")
result = model.transcribe("audio.aac")
print(result["text"])
