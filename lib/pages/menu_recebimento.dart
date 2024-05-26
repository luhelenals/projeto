import 'package:flutter/material.dart';
import 'package:projeto/pages/add_recebimento_page.dart';
import 'package:projeto/repositories/meses_repository.dart';
import 'package:projeto/repositories/recebimentos_repository.dart';
import 'package:projeto/configs/app_settings.dart';

class MenuRecebimento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabela = RecebimentosRepository.obterRecebimentoMensal(
        MesRepository.obterMesAtual().num);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppSettings.getCor(),
          title: Text('Recebimentos: ${MesRepository.obterMesAtual().nome}',
              style: TextStyle(color: AppSettings.getCorTexto()))),
      body: Center(
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
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
                                tabela.listaRecebimentos[linha].descricao,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                  'Data: ${tabela.listaRecebimentos[linha].data.day.toString()}/${tabela.listaRecebimentos[linha].data.month.toString()}/${tabela.listaRecebimentos[linha].data.year.toString()}'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                  'Valor: R\$${tabela.listaRecebimentos[linha].valor.toStringAsFixed(2)}'),
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
                              icon: const Icon(Icons.edit,
                                  color: Color(0xFF204522)),
                            ),
                          ),
                        ]),
                      );
                    },
                    separatorBuilder: (_, __) =>
                        const Divider(color: Colors.transparent),
                    itemCount: tabela.listaRecebimentos.length),
              ),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                /*IconButton(
                    onPressed: () {
                      //
                    },
                    icon: const Icon(Icons.arrow_back)),
                const SizedBox(width: 15),*/
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFDEFFDF)),
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(200, 50)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(color: Color(0xFF204522)),
                      ),
                    ),
                    child: const Text(
                      'Adicionar Recebimento',
                      style: TextStyle(
                          color: Color(0xFF204522),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddRecebimentoPage()),
                      );
                    }),
                /*const SizedBox(width: 15),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_forward)),*/
              ])
            ],
          )
        ]),
      ),
    );
  }
}
