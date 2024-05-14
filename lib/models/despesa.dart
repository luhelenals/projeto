import 'gasto_categoria.dart';

class Despesa {
  int id;
  double valor;
  String descricao;
  Categoria categoria;
  DateTime data;

  Despesa(
      {required this.id,
      required this.valor,
      required this.descricao,
      required this.categoria,
      required this.data});
}
