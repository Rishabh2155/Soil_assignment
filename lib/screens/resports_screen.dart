import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/readings_provider.dart';
import '../widgets/reading_card.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latest = ref.watch(latestReadingProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Center(
        child: latest.when(
          data: (r) => r == null
              ? const Text('No readings yet.')
              : ReadingCard(reading: r),
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('Error: $e'),
        ),
      ),
    );
  }
}
