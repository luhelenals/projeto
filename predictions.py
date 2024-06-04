import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import accuracy_score, classification_report
from flask import Flask, request, jsonify

def trainModel(base):
    """
    Treina um modelo Naive Bayes com dados de nomes e categorias.

    Parâmetros:
    base (str): Caminho para o arquivo Excel contendo os dados.

    Retorna:
    tuple: Contendo o vetorizador e o classificador treinado.
    """
    try:
        # Lendo os dados
        df = pd.read_excel(base)

        # Verificando se as colunas necessárias estão presentes
        if 'Nome' not in df.columns or 'Categoria' not in df.columns:
            raise ValueError("O dataframe deve conter as colunas 'Nome' e 'Categoria'.")

        # Separando os dados em features (X) e target (y)
        X = df['Nome']
        y = df['Categoria']

        # Dividindo os dados em conjuntos de treino e teste
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

        # Vetorizando os dados de treino
        vectorizer = CountVectorizer()
        X_train_counts = vectorizer.fit_transform(X_train)

        # Treinando o classificador
        classifier = MultinomialNB()
        classifier.fit(X_train_counts, y_train)

        # Vetorizando os dados de teste e fazendo previsões
        X_test_counts = vectorizer.transform(X_test)
        y_pred = classifier.predict(X_test_counts)

        # Avaliando o modelo
        '''accuracy = accuracy_score(y_test, y_pred)
        report = classification_report(y_test, y_pred)
        print(f"Acurácia: {accuracy:.2f}")
        print("Relatório de Classificação:")
        print(report)'''

        return vectorizer, classifier

    except Exception as e:
        print(f"Ocorreu um erro: {e}")

app = Flask(__name__)

# Train the model once and store vectorizer and classifier globally
vectorizer, classifier = trainModel('baseDados.xlsx')
mapping = {
    1: "Comida/bebida",
    2: "Lazer",
    3: "Limpeza",
    4: "Transporte",
    5: "Roupas/acessórios",
    6: "Casa",
    7: "Saúde/bem-estar",
    8: "Educação",
    9: "Outro"
}

@app.route('/predict', methods=['POST'])
def predict():
    # Get the JSON data from the request
    data = request.json
    produtos = data['produtos']

    # Transform and predict
    example_counts = vectorizer.transform(produtos)
    predictions = classifier.predict(example_counts)

    # Return the predictions as a JSON response
    categorias = [mapping[int(number)] for number in predictions]
    return jsonify(categorias)

if __name__ == '__main__':
    app.run(debug=True)