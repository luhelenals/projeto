import 'package:flutter/material.dart';
import 'package:projeto/models/despesa.dart';
import 'package:projeto/models/gasto_mes.dart';
import 'package:projeto/repositories/meses_repository.dart';
import 'add_despesa.dart';
import 'add_nota.dart';
import 'chave_acesso_page.dart';
import 'package:projeto/repositories/gastomes_repository.dart';

class MenuDespesa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GastoMensal>(
      future:
          GastoMensalRepository.obterGastos(MesRepository.obterMesAtual().num),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Enquanto os dados estão sendo carregados, exibe um indicador de progresso
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Se ocorrer um erro ao carregar os dados, exibe uma mensagem de erro
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          // Se os dados foram carregados com sucesso, exibe a interface do usuário com os dados
          GastoMensal tabela = snapshot.data!;
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
                      Despesa despesa = tabela.despesas[linha];
                      return Card(
                        color: const Color(0xFFDEFFDF),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    despesa.descricao,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    'Categoria: ${despesa.categoria.categoria.name}',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    'Data: ${despesa.data.day.toString()}/${despesa.data.month.toString()}/${despesa.data.year.toString()}',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    'Valor: R\$${despesa.valor.toStringAsFixed(2)}',
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  // Implemente a funcionalidade de edição aqui
                                },
                                icon: const Icon(Icons.edit,
                                    color: Color(0xFF204522)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, __) =>
                        const Divider(color: Colors.transparent),
                    itemCount: tabela.despesas.length,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFDEFFDF)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(75, 75)),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(color: Color(0xFF204522)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNotaPage()),
                        );
                      },
                      child: const Text(
                        'Ler QR Code',
                        style: TextStyle(
                          color: Color(0xFF204522),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFDEFFDF)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(75, 75)),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(color: Color(0xFF204522)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChaveDeAcessoPage()),
                        );
                      },
                      child: const Text(
                        'Digitar chave\nde acesso',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF204522),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFDEFFDF)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(75, 75)),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(color: Color(0xFF204522)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddDespesaPage()),
                        );
                      },
                      child: const Text(
                        'Adicionar outra\ndespesa',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF204522),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
