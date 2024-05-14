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
    List<enumCategoria> categorias = enumCategoria.values;
    int qtCat = categorias.length;
    List<double> valoresCategoria = List.filled(qtCat, 0);
    for (int i = 0; i < lista.length; i++) {
      int pos = categorias.indexOf(lista[i].categoria.categoria);
      valoresCategoria[pos] += lista[i].valor;
    }
    return valoresCategoria;
  }
}
