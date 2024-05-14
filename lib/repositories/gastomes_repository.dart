import 'dart:js_interop';

import 'package:projeto/models/gasto_mes.dart';
import 'package:projeto/repositories/meses_repository.dart';
import 'package:projeto/models/despesa.dart';
import 'package:projeto/models/gasto_categoria.dart';
import 'package:projeto/database/db.dart';

class GastoMensalRepository {
  static setupGastos() {
    return [
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
      ),
    ];
  }

  initRepsitory() async {
    var db = await DB.get();
    List tabela = await db.query('gastos');
    for (var despesa in tabela) {
      tabela.add(Despesa(
          id: despesa['id'],
          valor: despesa['nome'],
          descricao: despesa['nome'],
          categoria: despesa['categoria'],
          data: despesa['data']));
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
    List tabela = await db.query('gastos');
    GastoMensal gastos = tabela.firstWhere((gasto) => gasto.mes.num == num);

    return gastos;
  }
}
