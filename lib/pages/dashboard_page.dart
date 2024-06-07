import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projeto/configs/app_settings.dart';
import 'package:projeto/models/gasto_mes.dart';
import 'package:projeto/models/recebimento_mes.dart';
import 'package:projeto/repositories/gastomes_repository.dart';
import 'package:projeto/repositories/meses_repository.dart';
import 'package:projeto/repositories/recebimentos_repository.dart';
import 'package:projeto/models/mes.dart';
import 'package:projeto/models/pie_chart.dart';
import 'package:share/share.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late GastoMensal resumoGast;
  late RecebimentoMensal resumoReceb;
  Mes month = MesRepository.obterMes(DateTime.now().month);

  @override
  void initState() {
    super.initState();
    loadTabelas();
  }

  void loadTabelas() {
    setState(() {
      resumoGast = GastoMensalRepository.obterGastos(month.num);
      resumoReceb = RecebimentosRepository.obterRecebimentoMensal(month.num);
    });
  }

  @override
  Widget build(BuildContext context) {
    // cálculo de variáveis
    if (resumoGast.despesas.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Ainda sem gastos por aqui!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          MesesButton(),
        ],
      );
    } else {
      double progressValue = resumoReceb.valorTotal != 0
          ? resumoGast.valorTotal / resumoReceb.valorTotal
          : 0;

      // ainda não sei o que fazer quando for janeiro (código ano+mês em vez de só mês?)
      // 05/2024 -> 20245
      // 01/2024 -> 20241
      // 12/2023 -> 202312
      double diferencaMes = 0.0;
      if (month.num > 1) {
        GastoMensal gastosMesAnterior =
            GastoMensalRepository.obterGastos(month.num - 1);
        diferencaMes = gastosMesAnterior.valorTotal != 0
            ? gastosMesAnterior.valorTotal - resumoGast.valorTotal
            : 0;
      }

      List<double> listaGasto = [];
      List<String> listaNomes = [];

      if (resumoGast.despesas.isNotEmpty) {
        listaGasto = List.filled(resumoGast.despesas.length, 0);
        listaNomes = List.filled(resumoGast.despesas.length, '');
        for (int i = 0; i < resumoGast.despesas.length; i++) {
          listaGasto[i] = resumoGast.despesas[i].valor;
          listaNomes[i] = resumoGast.despesas[i].descricao;
        }
      }

      double valorItemMaiorGasto =
          listaGasto.isNotEmpty ? listaGasto.reduce(max) : 0;
      String itemMaiorGasto = listaGasto.isNotEmpty
          ? listaNomes[listaGasto.indexOf(valorItemMaiorGasto)]
          : '';

      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
                width: 420,
                height: 70,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF204522),
                ),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text(
                        'Você gastou ${(progressValue * 100).toStringAsFixed(2)}% dos seus recebimentos do mês.',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: progressValue, // Set the progress value here
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF587459)),
                        borderRadius: BorderRadius.circular(2),
                        minHeight: 3,
                      ),
                    ]))),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 190,
                    height: 90,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF204522),
                    ),
                    child: Center(
                        child: Text(
                      diferencaMes > 0
                          ? 'Você está R\$${diferencaMes.toStringAsFixed(2)} abaixo dos seus gastos do mês passado!'
                          : 'Você está R\$${(-1 * diferencaMes).toStringAsFixed(2)} acima dos seus gastos do mês passado!',
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ))),
                const SizedBox(width: 40),
                Container(
                    width: 190,
                    height: 90,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF204522),
                    ),
                    child: Center(
                      child: Text(
                          'Seu maior gasto do mês até agora foi com ${itemMaiorGasto.toString()} (R\$${valorItemMaiorGasto.toStringAsFixed(2)})',
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center),
                    )),
              ],
            ),
            const SizedBox(height: 30),
            GraficoGastosCategoria(
                currentMonth: MesRepository.obterMesAtual().num),
            const SizedBox(height: 30),
            MesesButton(),
            ElevatedButton(
              onPressed: () {
                Share.share('Check out this awesome app: [YOUR APP LINK HERE]');
              },
              child: Text('Compartilhar'),
            ),
          ],
        ),
      );
    }
  }
}

class MesesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFDEFFDF)),
        minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(color: Color(0xFF204522)),
        ),
      ),
      child: const Text(
        'Meses',
        style: TextStyle(
            color: Color(0xFF204522),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailedMonthPage()),
        );
      },
    );
  }
}

class DetailedSpendingPage extends StatefulWidget {
  final GastoMensal gastoMes;
  const DetailedSpendingPage({Key? key, required this.gastoMes})
      : super(key: key);

  @override
  _DetailedSpendingState createState() => _DetailedSpendingState();
}

class _DetailedSpendingState extends State<DetailedSpendingPage> {
  @override
  Widget build(BuildContext context) {
    final tabelaGasto =
        GastoMensalRepository.obterGastos(widget.gastoMes.mes.num);
    final tabelaReceb =
        RecebimentosRepository.obterRecebimentoMensal(widget.gastoMes.mes.num);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.gastoMes.mes.nome, style: TextStyle(color: AppSettings.getCorTexto())),
          backgroundColor: AppSettings.getCor(),
        ),
        body: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Text(
                'Gasto total: R\$${tabelaGasto.valorTotal.toStringAsFixed(2)}\n\nRecebimento total: R\$${tabelaReceb.valorTotal.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 550,
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
                                tabelaGasto.despesas[linha].descricao,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                  'Categoria: ${tabelaGasto.despesas[linha].categoria.categoria.name}'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                  'Data: ${tabelaGasto.despesas[linha].data.day.toString()}/${tabelaGasto.despesas[linha].data.month.toString()}/${tabelaGasto.despesas[linha].data.year.toString()}'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                  'Valor: R\$${tabelaGasto.despesas[linha].valor.toStringAsFixed(2)}'),
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
                    itemCount: tabelaGasto.despesas.length),
              ),
            ],
          ),
        ));
  }
}

class DetailedMonthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabela = GastoMensalRepository.tabela;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gastos por mês',
            style: TextStyle(color: AppSettings.getCorTexto())),
        backgroundColor: AppSettings.getCor(),
        iconTheme: IconThemeData(color: AppSettings.getCorTexto()),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int linha) {
          return ListTile(
            title: Text(
              tabela[linha].mes.nome,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: Text('R\$${tabela[linha].valorTotal.toStringAsFixed(2)}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailedSpendingPage(gastoMes: tabela[linha])),
              );
            },
          );
        },
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: tabela.length,
      ),
    );
  }
}
