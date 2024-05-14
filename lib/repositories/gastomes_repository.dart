import 'package:projeto/models/gasto_mes.dart';
import 'package:projeto/repositories/meses_repository.dart';
import 'package:projeto/models/despesa.dart';
import 'package:projeto/models/gasto_categoria.dart';
import 'package:projeto/database/db.dart';

class GastoMensalRepository {
  static setupGastos() {
    return [
      GastoMensal(mes: MesRepository.obterMes(1), despesas: [
        Despesa(
          valor: 54.30,
          descricao: 'Almoço',
          categoria: Categoria(categoria: enumCategoria.limpeza),
          data: DateTime(2024, 1, 3),
          id: 0,
        ),
        Despesa(
          valor: 120.0,
          descricao: 'Produtos de Limpeza',
          categoria: Categoria(categoria: enumCategoria.limpeza),
          data: DateTime(2024, 01, 08),
          id: 0,
        ),
        Despesa(
          valor: 200.0,
          descricao: 'Roupas',
          categoria: Categoria(
            categoria: enumCategoria.roupas,
          ),
          data: DateTime(2024, 01, 15),
          id: 0,
        ),
        Despesa(
          valor: 80.0,
          descricao: 'Consulta Médica',
          categoria: Categoria(
            categoria: enumCategoria.saude,
          ),
          data: DateTime(2024, 01, 20),
          id: 0,
        ),
        Despesa(
          valor: 50.0,
          descricao: 'Cinema',
          categoria: Categoria(
            categoria: enumCategoria.lazer,
          ),
          data: DateTime(2024, 01, 25),
          id: 0,
        )
      ]),
      GastoMensal(mes: MesRepository.obterMes(2), despesas: [
        Despesa(
          valor: 80.0,
          descricao: 'Jantar',
          categoria: Categoria(categoria: enumCategoria.comida),
          data: DateTime(2024, 02, 05),
          id: 0,
        ),
        Despesa(
          valor: 150.0,
          descricao: 'Produtos de Limpeza',
          categoria: Categoria(categoria: enumCategoria.limpeza),
          data: DateTime(2024, 02, 10),
          id: 0,
        ),
        Despesa(
          valor: 300.0,
          descricao: 'Roupas',
          categoria: Categoria(categoria: enumCategoria.roupas),
          data: DateTime(2024, 02, 15),
          id: 0,
        ),
        Despesa(
          valor: 200.0,
          descricao: 'Consulta Médica',
          categoria: Categoria(categoria: enumCategoria.saude),
          data: DateTime(2024, 02, 20),
          id: 0,
        ),
        Despesa(
          valor: 70.0,
          descricao: 'Cinema',
          categoria: Categoria(categoria: enumCategoria.lazer),
          data: DateTime(2024, 02, 25),
          id: 0,
        )
      ]),
      GastoMensal(mes: MesRepository.obterMes(3), despesas: [
        Despesa(
          valor: 80.0,
          descricao: 'Jantar',
          categoria: Categoria(categoria: enumCategoria.comida),
          data: DateTime(2024, 03, 05),
          id: 0,
        ),
        Despesa(
          valor: 150.0,
          descricao: 'Produtos de Limpeza',
          categoria: Categoria(categoria: enumCategoria.limpeza),
          data: DateTime(2024, 03, 10),
          id: 0,
        ),
        Despesa(
          valor: 300.0,
          descricao: 'Roupas',
          categoria: Categoria(categoria: enumCategoria.roupas),
          data: DateTime(2024, 03, 15),
          id: 0,
        ),
        Despesa(
          valor: 200.0,
          descricao: 'Consulta Médica',
          categoria: Categoria(categoria: enumCategoria.saude),
          data: DateTime(2024, 03, 20),
          id: 0,
        ),
        Despesa(
          valor: 70.0,
          descricao: 'Cinema',
          categoria: Categoria(categoria: enumCategoria.lazer),
          data: DateTime(2024, 03, 25),
          id: 0,
        )
      ]),
      GastoMensal(mes: MesRepository.obterMes(4), despesas: [
        Despesa(
          valor: 120.0,
          descricao: 'Almoço de trabalho',
          categoria: Categoria(categoria: enumCategoria.comida),
          data: DateTime(2024, 04, 03),
          id: 0,
        ),
        Despesa(
          valor: 80.0,
          descricao: 'Produtos de Limpeza',
          categoria: Categoria(categoria: enumCategoria.limpeza),
          data: DateTime(2024, 04, 10),
          id: 0,
        ),
        Despesa(
          valor: 500.0,
          descricao: 'Nova roupa para o trabalho',
          categoria: Categoria(categoria: enumCategoria.roupas),
          data: DateTime(2024, 04, 15),
          id: 0,
        ),
        Despesa(
          valor: 250.0,
          descricao: 'Medicamentos',
          categoria: Categoria(categoria: enumCategoria.saude),
          data: DateTime(2024, 04, 20),
          id: 0,
        ),
        Despesa(
          valor: 50.0,
          descricao: 'Ingresso para o teatro',
          categoria: Categoria(categoria: enumCategoria.lazer),
          data: DateTime(2024, 04, 25),
          id: 0,
        )
      ]),
      GastoMensal(mes: MesRepository.obterMes(5), despesas: [
        Despesa(
          valor: 90.0,
          descricao: 'Café da manhã',
          categoria: Categoria(
            categoria: enumCategoria.comida,
          ),
          data: DateTime(2024, 05, 03),
          id: 0,
        ),
        Despesa(
          valor: 70.0,
          descricao: 'Produtos de Higiene',
          categoria: Categoria(
            categoria: enumCategoria.limpeza,
          ),
          data: DateTime(2024, 05, 10),
          id: 0,
        ),
        Despesa(
          valor: 150.0,
          descricao: 'Camiseta',
          categoria: Categoria(
            categoria: enumCategoria.roupas,
          ),
          data: DateTime(2024, 05, 15),
          id: 0,
        ),
        Despesa(
          valor: 300.0,
          descricao: 'Exame de rotina',
          categoria: Categoria(
            categoria: enumCategoria.saude,
          ),
          data: DateTime(2024, 05, 20),
          id: 0,
        ),
        Despesa(
          valor: 80.0,
          descricao: 'Ingresso para o cinema',
          categoria: Categoria(
            categoria: enumCategoria.lazer,
          ),
          data: DateTime(2024, 05, 25),
          id: 0,
        )
      ]),
    ];
  }

  initRepsitory() async {
    var db = await DB.get();
    List tabela = await db.query('gastos');
    for (var despesaMensal in tabela) {
      for (var despesa in despesaMensal) {
        tabela.add(Despesa(
            id: despesa['id'],
            valor: despesa['nome'],
            descricao: despesa['nome'],
            categoria: despesa['categoria'],
            data: despesa['data']));
      }
    }
  }

  static void adicionarGasto(int numMes, Despesa despesa) async {
    var db = await DB.get();
    List tabela = await db.query('gastos');
    tabela.add({
      'id': despesa.id,
      'valor': despesa.valor,
      'descricao': despesa.descricao,
      'categoria': despesa.categoria,
      'data': despesa.data,
    });
  }

  static obterGastos(int num) async {
    var db = await DB.get();
    List<GastoMensal> tabela = await db.query('gastos');
    GastoMensal gastos = tabela.firstWhere((gasto) => gasto.mes.num == num);

    return gastos;
  }
}
