import sys
from gtts import gTTS
import os

def text_to_speech(input_text, output_file):
    tts = gTTS(text=input_text, lang='es')
    tts.save(output_file)

def main():
    if len(sys.argv) != 3:
        print("Usage: python script.py input_text_file output_audio_file")
        sys.exit(1)

    input_text_file = sys.argv[1]
    output_file = sys.argv[2]

    # Read text from input file
    with open(input_text_file, 'r', encoding='utf-8') as file:
        input_text = file.read().replace('\n', '')

    # Convert text to speech
    text_to_speech(input_text, output_file)
    print("Text converted to speech successfully!")

    # Play the audio file (for Windows)
    os.system("start " + output_file)

if __name__ == "__main__":
    main()

