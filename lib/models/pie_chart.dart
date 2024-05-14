/*import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:projeto/models/despesa.dart';
import 'dart:math';
import 'package:projeto/repositories/gastomes_repository.dart';
import 'package:projeto/repositories/meses_repository.dart';

class GraficoGastosCategoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch your data from repository
    List<Despesa> tabela =
        GastoMensalRepository.obterGastos(MesRepository.obterMesAtual().num)
            .despesas;

    // Create a map to store the total spending for each category
    Map<String, double> categoryMap = {};

    // Calculate the total spending for each category
    tabela.forEach((gasto) {
      if (categoryMap.containsKey(gasto.categoria.categoria)) {
        categoryMap[gasto.categoria.categoria.name] =
            (categoryMap[gasto.categoria.categoria.name] ?? 0) + gasto.valor;
      } else {
        categoryMap[gasto.categoria.categoria.name] = gasto.valor;
      }
    });

    // Convert the categoryMap to a list of PieChartSectionData
    List<PieChartSectionData> sections = categoryMap.entries.map((entry) {
      return PieChartSectionData(
        color: getRandomColor(), // You can define your own colors
        value: entry.value,
        title: '${entry.key}\n\$${entry.value.toStringAsFixed(2)}',
        radius: 100,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      );
    }).toList();

    return PieChart(
      PieChartData(
        sections: sections,
        borderData: FlBorderData(show: false),
        centerSpaceRadius: 40,
        sectionsSpace: 0,
        pieTouchData: PieTouchData(enabled: true),
      ),
    );
  }

  // Function to generate random color
  Color getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1.0);
  }
}*/