import 'package:projeto/models/mes.dart';
import 'despesa.dart';
import 'gasto_categoria.dart';

class GastoMensal {
  Mes mes;
  List<Despesa> despesas;
  late List<double> gastoCategorias;
  late double valorTotal;

  GastoMensal({
    required this.mes,
    required this.despesas,
  }) {
    gastoCategorias = pegarValoresDespesas(despesas);
    valorTotal = gastoCategorias.reduce((value, element) => value + element);
  }

  List<double> pegarValoresDespesas(List<Despesa> lista) {
  List<double> valoresCategoria = List.filled(enumCategoria.values.length, 0);

  for (int i = 0; i < lista.length; i++) {
    int pos = enumCategoria.values.indexOf(lista[i].categoria.categoria);
    valoresCategoria[pos] += lista[i].valor;
  }

  return valoresCategoria;
  }

  static double atualizarTotal(List<double> despesas) {
    return despesas.reduce((value, element) => value + element);
  }
}
