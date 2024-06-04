import requests
import pandas as pd

url = 'http://192.168.41.38:5000/predict'
urlData = 'http://127.0.0.1:5000/extrairNota?html=https://www.fazenda.pr.gov.br/nfce/qrcode?p=41240410358855000142650010002226261169500027|2|1|4|990ADA2DE222DA453358DD88DBAC9947CB20FB3C'

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

