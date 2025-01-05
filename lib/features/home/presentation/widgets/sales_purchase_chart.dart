import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stocks_app/core/theming/colors.dart';
import 'package:stocks_app/core/utils/spacing.dart';

class SalesPurchaseChart extends StatelessWidget {
  final Map<String, int> salesData;
  final Map<String, int> purchaseData;

  const SalesPurchaseChart({
    super.key,
    required this.salesData,
    required this.purchaseData,
  });

  @override
  Widget build(BuildContext context) {
    // Combine and sort dates from both sales and purchase data
    final Set<String> allDates = {...salesData.keys, ...purchaseData.keys};
    final List<String> sortedDates = allDates.toList()..sort();

    final List<FlSpot> salesSpots = _createSpots(sortedDates, salesData);
    final List<FlSpot> purchaseSpots = _createSpots(sortedDates, purchaseData);

    return Container(
      height: 380.h, // Adjust the height to allow space for indicators
      color: ColorsManager.white,
      padding: EdgeInsets.only(left: 16.w, top: 16.h),
      child: Column(
        children: [
          // Legend indicators below the chart
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sales Indicator
              _buildLegendIndicator(color: Colors.blue, label: 'Sales'),
              SizedBox(width: 20.w),
              // Purchase Indicator
              _buildLegendIndicator(color: Colors.green, label: 'Purchases'),
            ],
          ),
          verticalSpace(16),
          // Line Chart
          SizedBox(
            height: 300.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index < sortedDates.length) {
                          final rawDate = sortedDates[index];
                          final parsedDate = DateTime.tryParse(rawDate);
                          final day = parsedDate != null
                              ? DateFormat('d').format(parsedDate)
                              : '';
                          return Text(day,
                              style: const TextStyle(fontSize: 10));
                        }
                        return const Text('');
                      },
                      interval: 1,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  border: const Border(
                    top: BorderSide.none,
                    right: BorderSide.none,
                    left: BorderSide(width: 1),
                    bottom: BorderSide(width: 1),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: salesSpots,
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    belowBarData: BarAreaData(show: false),
                  ),
                  LineChartBarData(
                    spots: purchaseSpots,
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.green,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create legend indicators
  Widget _buildLegendIndicator({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }

  // Modify this method to make x-axis values progressive based on sorted dates
  List<FlSpot> _createSpots(List<String> dates, Map<String, int> data) {
    return dates
        .asMap() // This allows us to get both index and date
        .entries
        .map((entry) {
      // Use index as x value, not the date string itself
      double x = entry.key.toDouble();
      // Fetch the data value for the current date, default to 0 if missing
      double y = data[entry.value] != null ? data[entry.value]!.toDouble() : 0;
      return FlSpot(x, y);
    }).toList();
  }
}
