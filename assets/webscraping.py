import requests
from bs4 import BeautifulSoup
import pandas as pd

# extrair produtos com suas categorias (nome do produto) e preços, data da compra e forma de pagamento

def extrairNota (html):
    link = requests.get(html).text
    soup = BeautifulSoup(link, 'html.parser')

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

    linhaData = soup.find('strong', string=' Emissão: ').parent
    
    data = linhaData.get_text(strip=True)
    pos = data.find('Emissão:')+8
    data = data[pos:pos+10]
    
    dicionario = {
        'produtos': listaProdutos,
        'preços': listaPrecos,
        'método de pagamento': listaPagamentos,
        'data': data
    }
    
    return dicionario

def criaDF(dicionario):
    df = pd.DataFrame(dicionario[['produtos','precos']])
    df.rename(columns={'produtos': 'Item', 'precos': 'Valor'}, inplace=True)
    lista = []
    lista.append(dicionario['método de pagamento'])
    lista.append(dicionario['data'])
    return df, lista