import sys
import csv
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.svm import SVC

# Download NLTK resources
nltk.download('punkt')
nltk.download('stopwords')

def preprocess_text(text):
    tokens = word_tokenize(text.lower())  # Tokenization and lowercase conversion
    tokens = [token for token in tokens if token.isalpha()]  # Remove punctuation
    tokens = [token for token in tokens if token not in stopwords.words('english')]  # Remove stopwords
    return " ".join(tokens)

def train_model(texts, labels):
    # Text preprocessing
    processed_texts = [preprocess_text(text) for text in texts]

    # TF-IDF feature extraction
    vectorizer = TfidfVectorizer()
    X = vectorizer.fit_transform(processed_texts)

    # Train SVM model
    model = SVC(kernel='linear')
    model.fit(X, labels)

    return model, vectorizer

def predict_label(model, vectorizer, new_text):
    processed_new_text = preprocess_text(new_text)
    new_vector = vectorizer.transform([processed_new_text])
    prediction = model.predict(new_vector)
    return prediction[0]

def main(path_to_csv, new_text):
    

    # Read data from CSV
    texts = []
    labels = []
    with open(path_to_csv, 'r', encoding='utf-8') as csvfile:
        csvreader = csv.reader(csvfile, delimiter=';')
        next(csvreader)  # Skip header
        for row in csvreader:
            texts.append(row[0])
            labels.append(row[1])

    # Train model
    model, vectorizer = train_model(texts, labels)

    # Predict label for new text
    prediction = predict_label(model, vectorizer, new_text)
    return prediction

