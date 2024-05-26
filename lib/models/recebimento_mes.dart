import 'recebimento.dart';
import 'mes.dart';

class RecebimentoMensal {
  List<Recebimento> listaRecebimentos;
  Mes mes;
  late double valorTotal;

  RecebimentoMensal({required this.listaRecebimentos, required this.mes}) {
    valorTotal = obterRecebimentoTotal(listaRecebimentos);
  }

  static double obterRecebimentoTotal(List<Recebimento> lista) {
    double soma = 0;
    for (int i = 0; i < lista.length; i++) {
      soma += lista[i].valor;
    }
    return soma;
  }
}
