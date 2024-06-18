import 'package:flutter/material.dart';
import 'package:projeto/configs/app_settings.dart';
import 'package:projeto/pages/menu_despesa.dart';
import 'package:projeto/pages/more_page.dart';
import 'dashboard_page.dart';
import 'settings_page.dart';
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
        items: const [
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
            icon: Icon(Icons.newspaper),
            label: 'Novidades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppSettings.getCorTema(),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const DashboardPage();
      case 1:
        return MenuRecebimento();
      case 2:
        return MenuDespesa();
      case 3:
        return MorePage();
      case 4:
        return const SettingsPage();
      default:
        return Container();
    }
  }
}
