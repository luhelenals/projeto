import 'package:projeto/models/recebimento.dart';
import 'package:projeto/models/recebimento_mes.dart';
import 'package:projeto/repositories/meses_repository.dart';

class RecebimentosRepository {
  static List<RecebimentoMensal> tabela = [
    RecebimentoMensal(listaRecebimentos: [
      Recebimento(valor: 500.23, data: DateTime(2024, 5, 6), descricao: 'pix'),
      Recebimento(
          valor: 2780.0, data: DateTime(2024, 5, 1), descricao: 'Salário'),
      Recebimento(
          valor: 600.50, data: DateTime(2024, 5, 15), descricao: 'Bolsa'),
      Recebimento(
          valor: 20.50, data: DateTime(2024, 5, 15), descricao: 'Cashback'),
    ], mes: MesRepository.obterMes(5)),
    RecebimentoMensal(listaRecebimentos: [
      Recebimento(
          valor: 130.00, data: DateTime(2024, 4, 27), descricao: 'Presente'),
      Recebimento(
          valor: 2780.0, data: DateTime(2024, 4, 1), descricao: 'Salário'),
      Recebimento(
          valor: 600.50, data: DateTime(2024, 4, 15), descricao: 'Bolsa'),
    ], mes: MesRepository.obterMes(4)),
    RecebimentoMensal(listaRecebimentos: [
      Recebimento(valor: 500.40, data: DateTime(2024, 3, 13), descricao: 'Pix'),
      Recebimento(
          valor: 2780.0, data: DateTime(2024, 3, 1), descricao: 'Salário'),
      Recebimento(
          valor: 300.50, data: DateTime(2024, 3, 15), descricao: 'Bolsa'),
    ], mes: MesRepository.obterMes(3)),
    RecebimentoMensal(listaRecebimentos: [
      Recebimento(
          valor: 370.3, data: DateTime(2024, 2, 6), descricao: 'Auxílio'),
      Recebimento(
          valor: 2780.0, data: DateTime(2024, 2, 1), descricao: 'Salário'),
      Recebimento(
          valor: 600.50, data: DateTime(2024, 2, 15), descricao: 'Bolsa'),
      Recebimento(
          valor: 65.70,
          data: DateTime(2024, 2, 18),
          descricao: 'Estorno compra'),
    ], mes: MesRepository.obterMes(2)),
    RecebimentoMensal(listaRecebimentos: [
      Recebimento(valor: 500.23, data: DateTime(2024, 1, 30), descricao: 'pix'),
      Recebimento(
          valor: 2780.0, data: DateTime(2024, 1, 1), descricao: 'Salário'),
      Recebimento(
          valor: 600.50, data: DateTime(2024, 1, 15), descricao: 'Bolsa'),
      Recebimento(
          valor: 1380.0,
          data: DateTime(2024, 1, 5),
          descricao: 'Décimo terceiro')
    ], mes: MesRepository.obterMes(1)),
  ];

  static RecebimentoMensal obterRecebimentoMensal(int n) {
    RecebimentoMensal recebimentos =
        tabela.firstWhere((recebimento) => recebimento.mes.num == n);
    return recebimentos;
  }

  static void adicionarRecebimento(int mes, Recebimento recebimento) {
    RecebimentoMensal recebimentos =
        tabela.firstWhere((element) => element.mes.num == mes);
    recebimentos.listaRecebimentos.add(recebimento);
    recebimentos.valorTotal =
        RecebimentoMensal.obterRecebimentoTotal(recebimentos.listaRecebimentos);
  }
}
