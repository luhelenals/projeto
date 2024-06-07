import 'gasto_categoria.dart';

class Despesa {
  double valor;
  String descricao;
  Categoria categoria;
  DateTime data;
  bool exibir;

  Despesa({
    required this.valor,
    required this.descricao,
    required this.categoria,
    required this.data,
    this.exibir = true
  });
}
