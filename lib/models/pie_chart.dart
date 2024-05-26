import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:projeto/repositories/gastomes_repository.dart';
import 'package:projeto/models/gasto_categoria.dart';

class GraficoGastosCategoria extends StatelessWidget {
  final int currentMonth;

  GraficoGastosCategoria({required this.currentMonth});

  Future<List<PieChartSectionData>> _getPieChartSections(int month) async {
    final expenses = GastoMensalRepository.obterGastos(month).despesas;
    final Map<enumCategoria, double> categoryTotals = {};

    for (var expense in expenses) {
      categoryTotals.update(
        expense.categoria.categoria,
        (value) => value + expense.valor,
        ifAbsent: () => expense.valor,
      );
    }

    return categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        color: _getColorForCategory(entry.key),
        value: entry.value,
        title: entry.key.name,
        radius: 70,
      );
    }).toList();
  }

  Color _getColorForCategory(enumCategoria category) {
    switch (category) {
      case enumCategoria.comida:
        return Colors.blue;
      case enumCategoria.limpeza:
        return Colors.green;
      case enumCategoria.roupas:
        return Colors.orange;
      case enumCategoria.saude:
        return Colors.red;
      case enumCategoria.lazer:
        return Colors.purple;
      case enumCategoria.transporte:
        return Colors.yellow;
      case enumCategoria.educacao:
        return Colors.cyan;
      case enumCategoria.casa:
        return Colors.brown;
      case enumCategoria.outro:
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PieChartSectionData>>(
      future: _getPieChartSections(currentMonth),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<PieChartSectionData>? pieChartSections = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 200, // Provide a specific height for the PieChart
                    child: PieChart(
                      PieChartData(
                        sections: pieChartSections,
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ),
                /*...pieChartSections!.map((section) {
                  return ListTile(
                    leading: Icon(Icons.label, color: section.color),
                    title: Text(section.title),
                    trailing: Text('${section.value.toStringAsFixed(2)}'),
                  );
                }).toList(),*/
              ],
            ),
          );
        }
      },
    );
  }
}
