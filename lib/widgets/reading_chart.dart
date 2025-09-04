import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/reading.dart';

class ReadingChart extends StatelessWidget {
  final List<Reading> readings;
  const ReadingChart({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    if (readings.isEmpty) return const SizedBox.shrink();

    final moistSpots = <FlSpot>[];
    final tempSpots = <FlSpot>[];
    // x = index (time order), keep simple
    for (int i = 0; i < readings.length; i++) {
      moistSpots.add(FlSpot(i.toDouble(), readings[i].moisturePct));
      tempSpots.add(FlSpot(i.toDouble(), readings[i].temperatureC));
    }

    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (readings.length - 1).toDouble(),
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: true),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (readings.length / 4).clamp(1, 10).toDouble(),
                getTitlesWidget: (v, _) => Text(v.toInt().toString(),
                    style: const TextStyle(fontSize: 10)),
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: moistSpots,
              isCurved: true,
              dotData: const FlDotData(show: false),
              // default color set by library theme
            ),
            LineChartBarData(
              spots: tempSpots,
              isCurved: true,
              dotData: const FlDotData(show: false),
            ),
          ],
          lineTouchData: const LineTouchData(enabled: true),
        ),
      ),
    );
  }
}
