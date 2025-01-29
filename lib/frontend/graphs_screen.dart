import 'package:finance_tracker/backend/finance_state.dart';
import 'package:finance_tracker/shared/finance_enums.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraphsScreen extends StatelessWidget {
  final List<UpdateFinanceValues> financeRecords;

  GraphsScreen({required this.financeRecords});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Charts')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text("Pie chart per category"),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 200,
              height: 200,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 30,
                  sections: financeRecords.isNotEmpty
                      ? [
                          for (int j = 0; j < FinanceCategory.values.length; j++)
                            PieChartSectionData(
                              value: _calculateTotalForCategory(FinanceCategory.values[j]),
                              title: FinanceCategory.values[j].toString().split('.').last,
                              color: Colors.primaries[j % Colors.primaries.length],
                            ),
                        ]
                      : [PieChartSectionData(value: 1, title: "No Data", color: Colors.grey)],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text("Balance Trend (Last 6 Months)"),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 500,
                height: 500,
                child: LineChart(
                _buildLineChartData(),
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper function to calculate total per category
  double _calculateTotalForCategory(FinanceCategory category) {
    double total = financeRecords
        .where((record) => record.category == category)
        .fold(0.0, (sum, record) => sum + (record.amount ?? 0.0));
    return total.isNaN ? 0.0 : total;
  }

  /// Function to prepare line chart data
  LineChartData _buildLineChartData() {
    List<FlSpot> dataPoints = _getLast6MonthsData();
    
    return LineChartData(
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, interval: 100, reservedSize: 50),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text(_getMonthLabel(value.toInt()), style: TextStyle(fontSize: 10));
            },
            interval: 1, // Shows 6 labels
          ),
        ),
      ),
      borderData: FlBorderData(show: true),
      gridData: FlGridData(show: true),
      lineBarsData: [
        LineChartBarData(
          spots: dataPoints,
          isCurved: true, // Smooth curve
          color: Colors.blue,
          barWidth: 4,
          dotData: FlDotData(show: true),
        ),
      ],
    );
  }

  /// Function to get balance data for the last 6 months
  List<FlSpot> _getLast6MonthsData() {
    DateTime now = DateTime.now();
    Map<int, double> monthBalance = {for (int i = 5; i >= 0; i--) now.month - i: 0.0};

    for (var record in financeRecords) {
      if (record.date.isAfter(now.subtract(Duration(days: 180)))) {
        int month = record.date.month;
        monthBalance[month] = (monthBalance[month] ?? 0) + record.amount;
      }
    }

    List<FlSpot> spots = [];
    monthBalance.forEach((month, balance) {
      spots.add(FlSpot(month.toDouble(), balance));
    });

    return spots;
  }

  /// Function to get month label from month number
  String _getMonthLabel(int month) {
    return DateFormat.MMM().format(DateTime(DateTime.now().year, month, 1));
  }
}
