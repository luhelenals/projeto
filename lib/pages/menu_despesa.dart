import 'package:flutter/material.dart';
import 'package:projeto/repositories/meses_repository.dart';
import 'add_despesa.dart';
import 'add_nota.dart';
import 'chave_acesso_page.dart';
import 'package:projeto/repositories/gastomes_repository.dart';

class MenuDespesa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabela =
        GastoMensalRepository.obterGastos(MesRepository.obterMesAtual().num);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gastos: ${MesRepository.obterMesAtual().nome}'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Total: R\$${tabela.valorTotal.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 450,
            width: 400,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int linha) {
                  return Card(
                    color: const Color(0xFFDEFFDF),
                    child: Stack(children: [
                      Column(children: [
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            tabela.despesas[linha].descricao,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                              'Categoria: ${tabela.despesas[linha].categoria.categoria.name}'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                              'Data: ${tabela.despesas[linha].data.day.toString()}/${tabela.despesas[linha].data.month.toString()}/${tabela.despesas[linha].data.year.toString()}'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                              'Valor: R\$${tabela.despesas[linha].valor.toStringAsFixed(2)}'),
                        ),
                        const SizedBox(height: 10),
                      ]),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditarRecebimento()),
                            );*/
                          },
                          icon:
                              const Icon(Icons.edit, color: Color(0xFF204522)),
                        ),
                      ),
                    ]),
                  );
                },
                separatorBuilder: (_, __) =>
                    const Divider(color: Colors.transparent),
                itemCount: tabela.despesas.length),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFDEFFDF)),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(75, 75)),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(color: Color(0xFF204522)),
                  ),
                ),
                child: const Text(
                  softWrap: true,
                  'Ler QR Code',
                  style: TextStyle(
                    color: Color(0xFF204522),
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddNotaPage()),
                  );
                }),
            const SizedBox(
              width: 5,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFDEFFDF)),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(75, 75)),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(color: Color(0xFF204522)),
                  ),
                ),
                child: const Text(
                  softWrap: true,
                  'Digitar chave\nde acesso',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF204522),
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChaveDeAcessoPage()),
                  );
                }),
            const SizedBox(
              width: 5,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFDEFFDF)),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(75, 75)),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(color: Color(0xFF204522)),
                  ),
                ),
                child: const Text(
                  softWrap: true,
                  'Adicionar outra\ndespesa',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF204522),
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddDespesaPage()),
                  );
                }),
          ])
        ],
      ),
    );
  }
}
