Esta branch contém os códigos elaborados para a extração dos dados de notas fiscais da web, além da
categorização dos itens através de um modelo de treinamento de Naive Bayes.

Para funcionamento adequado das chamadas de APIs do projeto:
1. Os arquivos webscraping.py e predictions.py devem ser executados e o endereço do local host deve ser
   atualizado caso seja necessário.
   (Note que baseDados.xlsx deve estar na mesma pasta ou ter seu endereço atualizado em predictions.py);
2. O arquivo enviaDados.py deve ser executado, também atualizando o endereço caso necessário.
3. Pode-se utilizar para teste os urls contidos em urlsExemploProjeto.txt, substituindo-o no urlData em
   enviaDados.py
