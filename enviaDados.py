import requests
import pandas as pd

url = 'http://127.0.0.1:5000/predict'
urlData = 'http://127.0.0.1:5000/extrairNota?html=http://www.fazenda.pr.gov.br/nfce/qrcode?p=41240576189406004202651140003487451000812851|2|1|1|C21AEC2D83BB16683380CDCF4015516C65DDAD15'

data = requests.get(urlData)
if data.status_code == 200:
    # Carregando o JSON retornado pela resposta
    dados_json = data.json()

    # Acessando a lista 'produtos'
    data = {'produtos': dados_json['content']['produtos']}

    response = requests.post(url, json=data)
    if response.status_code == 200:
        predictions = response.json()
        dic = {'item': data['produtos'],
            'categoria': predictions}
        print(pd.DataFrame(dic))
    else:
        print("Erro response:", response.status_code, response.text)
else:
    print("Erro:", data.status_code, data.text)

