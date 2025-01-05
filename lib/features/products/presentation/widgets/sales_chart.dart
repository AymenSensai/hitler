import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SalesChart extends StatelessWidget {
  final List<Map<String, dynamic>> salesData;

  const SalesChart({super.key, required this.salesData});

  @override
  Widget build(BuildContext context) {
    if (salesData.isEmpty) {
      return Center(
        child: Text('No sales data available'),
      );
    }

    return SizedBox(
      height: 300.h,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles()),
            topTitles: AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < salesData.length) {
                    final rawDate = salesData[index]
                        ['date']; // Assuming the date is in 'yyyy-MM-dd' format
                    final parsedDate = DateTime.tryParse(rawDate);
                    final day = parsedDate != null
                        ? DateFormat('d').format(parsedDate)
                        : '';
                    return Text(
                      day,
                      style: const TextStyle(fontSize: 10),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: (salesData.length - 1).toDouble(),
          minY: 0,
          maxY: salesData.isNotEmpty
              ? salesData
                  .map((e) => e['quantity'])
                  .reduce((a, b) => a > b ? a : b)
                  .toDouble()
              : 0,
          lineBarsData: [
            LineChartBarData(
              spots: salesData
                  .asMap()
                  .entries
                  .map((entry) => FlSpot(
                      entry.key.toDouble(), entry.value['quantity'].toDouble()))
                  .toList(),
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              isStrokeCapRound: true,
            ),
          ],
        ),
      ),
    );
  }
}
