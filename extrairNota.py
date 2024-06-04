import requests
from bs4 import BeautifulSoup
import pandas as pd
from flask import Flask, request, jsonify
import time

app = Flask(__name__)

# Endpoint para extrair produtos e categorizá-los
categoria_server_url = "http://127.0.0.1:5000/predict"

@app.route('/')
def extrairNota ():
    html = request.args.get('html')  # Obter o parâmetro 'html' da solicitação
    if html is None:
        return jsonify({"error": "Missing 'html' parameter"}), 400

    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'}
    
    # Implement retry logic
    for attempt in range(5):
        try:
            response = requests.get(html, headers=headers, timeout=10)
            response.raise_for_status()
            break  # Exit the loop if the request is successful
        except requests.exceptions.RequestException as e:
            print(f"Attempt {attempt + 1} failed: {e}")
            time.sleep(2)  # Wait before retrying
    else:
        print("Failed to retrieve the webpage after multiple attempts.")
        return None

    soup = BeautifulSoup(response.text, 'html.parser')

    # número de itens para iteração
    totalItens = int(soup.find('span', class_ = 'totalNumb').text)
    itens = []
    
    for numItem in range(totalItens):
        itens.append(soup.find('tr', id = f'Item + {numItem+1}'))
    
    # listas de nomes e preços dos produtos da nota
    listaProdutos = []
    listaPrecos = []

    for item in itens:
        nome = item.find('span', class_ = 'txtTit2').text
        preco = item.find('span', class_ = 'valor').text
        listaProdutos.append(nome)
        listaPrecos.append(preco)

    # lista de forma(s) de pagamento(s)
    pagamentos = soup.find_all('div', id = 'linhaTotal')
    for a in pagamentos:
        if not a.find('label', class_ = 'tx'):
            a.decompose()
    listaPagamentos = []
    for pagamento in pagamentos:
        infos = pagamento.text
        infos = infos.split('\n')
        for item in infos:
            if item == '':
                infos.remove(item)
        if infos != []:
            listaPagamentos.append(infos)

    try:
        linhaData = soup.find('strong', string=' Emissão: ').next_sibling.strip()
        data = linhaData.split()[0]  # Extract only the date part
    except AttributeError:
        print("Error: Could not find the emission date.")
        return None
    
    dicionario = {
        'produtos': listaProdutos,
        'preços': listaPrecos,
        'método de pagamento': listaPagamentos,
        'data': data
    }

    # Aqui, você tem o dicionário 'dicionario' contendo os produtos e outras informações extraídas
    # Vamos enviar esses dados para o servidor de categorização
    try:
        response = requests.post(categoria_server_url, json={"produtos": dicionario["produtos"]})
        response.raise_for_status()
        categorias = response.json()
    except requests.exceptions.RequestException as e:
        print(f"Failed to categorize products: {e}")
        categorias = None

    if categorias is not None:
        dicionario['categorias'] = categorias

    df = criaDF(dicionario)
    
    return jsonify({"content": df.to_dict()})


def criaDF(dicionario):
    df = pd.DataFrame(dicionario[['produtos','precos']])
    df.rename(columns={'produtos': 'Item', 'precos': 'Valor'}, inplace=True)
    lista = []
    lista.append(dicionario['método de pagamento'])
    lista.append(dicionario['data'])
    return df, lista

if __name__ == '__main__':
    app.run(debug=True)
