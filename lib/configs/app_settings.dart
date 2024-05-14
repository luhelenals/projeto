/*import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:projeto/models/gasto_mes.dart';
import 'package:projeto/models/recebimento_mes.dart';
import 'package:projeto/repositories/gastomes_repository.dart';
import 'package:projeto/repositories/recebimentos_repository.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  //late SharedPreferences _prefs;
  late Box box;
  Map<String, List<GastoMensal>> gastos = {
    'gastos': GastoMensalRepository.tabela
  };
  Map<String, List<RecebimentoMensal>> recebimentos = {
    'recebimentos': RecebimentosRepository.tabela
  };

  AppSettings() {
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLocale();
  }

  Future<void> _startPreferences() async {
    //_prefs = await SharedPreferences.getInstance();
    box = await Hive.openBox('valores');
  }

  _readValores() {
    final recebimentos = ;
    final 
  }
}
*/