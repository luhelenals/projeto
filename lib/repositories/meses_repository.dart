import 'package:projeto/models/mes.dart';

class MesRepository {
  static List<Mes> tabela = [
    Mes(
      nome: 'Janeiro',
      num: 1,
    ),
    Mes(nome: 'Fevereiro', num: 2),
    Mes(
      nome: 'Março',
      num: 3,
    ),
    Mes(
      nome: 'Abril',
      num: 4,
    ),
    Mes(
      nome: 'Maio',
      num: 5,
    ),
    Mes(
      nome: 'Junho',
      num: 6,
    ),
    Mes(
      nome: 'Julho',
      num: 7,
    ),
    Mes(
      nome: 'Agosto',
      num: 8,
    ),
    Mes(
      nome: 'Setembro',
      num: 9,
    ),
    Mes(
      nome: 'Outubro',
      num: 10,
    ),
    Mes(
      nome: 'Novembro',
      num: 11,
    ),
    Mes(
      nome: 'Dezembro',
      num: 12,
    ),
  ];

  static Mes obterMesAtual() {
    // Obtenha o número do mês atual
    int numeroMesAtual = DateTime.now().month;

    // Encontre o objeto Mes correspondente ao mês atual
    Mes mesAtual = tabela.firstWhere((mes) => mes.num == numeroMesAtual);

    return mesAtual;
  }

  static Mes obterMes(int n) {
    Mes mes = tabela.firstWhere((mes) => mes.num == n);
    return mes;
  }
}
