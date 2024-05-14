import 'package:flutter/material.dart';
//import 'package:projeto/models/mes.dart';
import 'package:projeto/pages/menu_despesa.dart';
//import 'package:projeto/repositories/gastomes_repository.dart';
//import 'package:projeto/repositories/meses_repository.dart';
//import 'package:projeto/repositories/recebimentos_repository.dart';
import 'dashboard_page.dart';
import 'more_page.dart';
import 'menu_recebimento.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.input});

  final List input;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Visão geral',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Recebimento',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Despesa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'Mais',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF204522),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        //Mes mes = MesRepository.obterMes(DateTime.now().month);
        return const DashboardPage(
            //month: mes,
            //resumoGast: GastoMensalRepository.obterGastos(mes.num),
            //resumoReceb: RecebimentosRepository.obterRecebimentoMensal(mes.num),
            );
      case 1:
        return MenuRecebimento();
      case 2:
        return MenuDespesa();
      case 3:
        return const MorePage();
      default:
        return Container();
    }
  }
}
