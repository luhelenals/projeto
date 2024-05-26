import 'gasto_categoria.dart';

class Despesa {
  double valor;
  String descricao;
  Categoria categoria;
  DateTime data;

  Despesa(
      {required this.valor,
      required this.descricao,
      required this.categoria,
      required this.data});
}
