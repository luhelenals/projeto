import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import accuracy_score, classification_report

def trainModel(base):
    # lendo e randomizando os dados
    df = pd.read_excel(base)

    X = df['Nome']
    y = df['Categoria']

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    vectorizer = CountVectorizer()
    counts = vectorizer.fit_transform(df['Nome'].values)

    classifier = MultinomialNB()
    targets = df['Categoria'].values
    classifier.fit(counts, targets) 
    

    """ X_test_counts = vectorizer.transform(X_test)
    y_pred = classifier.predict(X_test_counts)
    accuracy = accuracy_score(y_test, y_pred)
    report = classification_report(y_test, y_pred)
    print(f"Acurácia: {accuracy:.2f}")
    print("Relatório de Classificação:")
    print(report) """

    return vectorizer, classifier

vectorizer, classifier = trainModel('baseDados.xlsx')

produtos = [
      "ARROZ PRATO FINO BCO 2KG",
      "ACUCAR COLOMBO CRISTAL 2KG",
      "MASSA RENATA CO CARACOLINO 500G",
      "MASSA RENATA CO CARACOLINO 500G",
      "MASSA RENATA CO PENA 500G",
      "FARINHA DE TRIGO ANACONDA 1KG",
      "EXTRATO TOMATE ELEFANTE 190G",
      "EXTRATO TOMATE ELEFANTE 190G",
      "OLEO DE SOJA COAMO 900ML PET",
      "SABAO PO TIXAN PRIMAVERA 2,2KG",
      "REFRIG.COCA COLA 2L PET",
      "DETERG.YPE CLEAR CARE 500ML",
      "MIST.PBOLO RENATA LJA 400G",
      "REQUEIJAO TIROL TRAD.180G",
      "BEB.LACTEA TIROL FTASCEREAIS 830G",
      "AIPIM MARIANO DESCASCADO 1KG",
      "LEITE CONDENSADO ITALAC 395G",
      "MARG.QUALY CSAL 500G",
      "BATATA BRANCA LAVADA KG",
      "LINGUICA FRIMESA TP CALAB.DEF.KG",
      "CENOURA KG",
      "ABOBORA MENINA SECA KG",
      "BATATA DOCE ROXA KG",
      "DESOD.REXONA AERO CLINICAL FRESH F 150ML",
      "DESOD.REXONA AERO CLINICAL FRESH F 150ML",
      "COGUMELO PARIS 200G",
      "CHOC.HERSHEY.S COOKIES CREME 77G",
      "CHOC.HERSHEY.S FLOCOS OVOMALTINE 77G",
      "CHOC.GAROTO CAJUPASSAS 80G",
      "CHOC.HERSHEY.S AERADO 85G",
      "BISC.TODDY COOKIES BAUNCHOC.133G",
      "BATATA ASTERIX KG",
      "LIMAO TAHITI KG",
      "CEBOLA KG",
      "QUEIJO TIROL MUSS.FAT.400G",
      "TOALHA DE PAPEL CONDOR C2 100F",
      "SACO CONDOR FREEZER 5KG C50",
      "LEITE PO PARMALAT ZERO LAC.INST.300G",
      "PAO FORMA 480G PULLMAN",
      "PAO PULLMAN BISNAGUITO 300G",
      "LEITE BATAVO INTEG.1L UHT",
      "COXINHA DA ASA COPACOL TEMP.CONG.1KG",
      "FILEZINHO SASSAMI COPACOL CONG.1KG",
      "PRESUNTO FRIMESA FAT.200G",
      "SACO PLIXO CONDOR AZUL 50L C20",
      "CR.DENTAL COLGATE MPA 90G",
      "SAB.NIVEA ERVA DOCE 85G",
      "TEMPERO SWEET CNE RIBS 50G",
      "LOURO EM FOLHAS SWEET 3G",
      "TEMPERO DO EDU SWEET 30G",
      "TIRINHAS DE FRANGO AURORA 300G",
      "SAB.NIVEA ORQUIDEA 85G",
      "ESC.DENTAL COLGATE CLASSIC CLEAN L3 P2",
      "ESPONJA ESFREBOM TEFLON C3",
      "OREGANO STRAFIT 10G",
      "CHOC.DORI GRANULADO 120G",
      "LOURO STRAFIT PO 10G",
      "MASSA NISSIN GALINHA CAIPIRA 85G",
      "CREME DE LEITE TIROL 200G TP",
      "MASSA NISSIN CNE 85G",
      "FILEZINHO SASSAMI COPACOL CONG.1KG",
      "MASSA NISSIN CNE 85G",
      "MASSA NISSIN GALINHA CAIPIRA 85G",
      "REQUEIJAO TIROL CREMOSO TRAD.400G",
      "MANTEIGA TIROL CSAL 200G POTE",
      "DOCE DE LEITE FRIMESA CCHOC.400G",
      "MASSA PPASTEL ROMANHA DCO GDE 500G",
      "MARACUJA SUCO KG",
      "MOLHO SAKURA TRAD.150ML PET",
      "PAPEL HIG.DUETTO VELVET FD 30M C12",
      "FILTRO DE PAPEL BRIGITTA 103 C30",
      "BISC.BAUDUCCO WAFFER TRIPLO CHOC.140G",
      "OVOS BCO GDE C12",
      "LUA DE MEL CREME KG",
      "LUA DE MEL DOCE DE LEITE KG",
      "PAO DE FRIOS KG",
      "CANECA LYOR DOTS PORCELANA SORT.295ML",
      "BOLO VO ANA FORMIGUEIRO"
]

example_counts = vectorizer.transform(produtos)
predictions = classifier.predict(example_counts)

print(predictions)