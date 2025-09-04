import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/readings_provider.dart';
import '../widgets/reading_chart.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readings = ref.watch(readingsStreamProvider);
    final df = DateFormat('MMM d, yyyy • HH:mm');
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: readings.when(
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('No readings yet.'));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ReadingChart(readings: list.reversed.toList()),
                ),
              ),
              const SizedBox(height: 12),
              ...list.map((r) => Card(
                child: ListTile(
                  title: Text(
                      'Temp: ${r.temperatureC}°C, Moisture: ${r.moisturePct}%'),
                  subtitle: Text(df.format(r.timestamp)),
                ),
              )),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
