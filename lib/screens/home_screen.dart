import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soil_health/screens/resports_screen.dart';
import '../providers/auth_provider.dart';
import '../providers/ble_provider.dart';
import '../providers/readings_provider.dart';
import '../services/firebase_service.dart';
import '../models/reading.dart';
import 'history_sceen.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _testReading(WidgetRef ref, BuildContext context) async {
    final ble = ref.read(bleServiceProvider);
    final svc = ref.read(firebaseServiceProvider);

    if (!ble.isConnected) {
      await ble.scanAndConnect();
      ref.read(bleConnectionProvider.notifier).state = true;
    }

    final reading = await ble.fetchReading();
    final user = svc.authStateChanges();
    final current = await user.first;
    if (current == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Not authenticated.')));
      }
      return;
    }
    await svc.addReading(current.uid, reading);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Saved: ${reading.temperatureC}°C, ${reading.moisturePct}%')));
    }
    // refresh latest + history
    ref.invalidate(latestReadingProvider);
    ref.invalidate(readingsStreamProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final svc = ref.watch(firebaseServiceProvider);
    final connected = ref.watch(bleConnectionProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            tooltip: 'History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              );
            },
            icon: const Icon(Icons.history),
          ),
          IconButton(
            tooltip: 'Sign out',
            onPressed: () => svc.signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(
                      connected ? Icons.bluetooth_connected : Icons.bluetooth,
                      color: connected ? Colors.green : null,
                    ),
                    title: Text(connected ? 'Device Connected' : 'Not Connected'),
                    subtitle:
                    const Text('Mock device'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () => _testReading(ref, context),
                        child: const Text('Test'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ReportsScreen()),
                          );
                        },
                        child: const Text('Reports'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
