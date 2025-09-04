import 'dart:math';
import '../models/reading.dart';

abstract class BluetoothService {
  Future<void> scanAndConnect();
  Future<Reading> fetchReading();
  bool get isConnected;
}

class MockBluetoothService implements BluetoothService {
  bool _connected = false;
  final _rng = Random();

  @override
  bool get isConnected => _connected;

  @override
  Future<void> scanAndConnect() async {
    await Future.delayed(const Duration(seconds: 1));
    _connected = true;
  }

  @override
  Future<Reading> fetchReading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final temp = 20 + _rng.nextDouble() * 15;
    final moist = 20 + _rng.nextDouble() * 60;
    return Reading(
      timestamp: DateTime.now(),
      temperatureC: double.parse(temp.toStringAsFixed(1)),
      moisturePct: double.parse(moist.toStringAsFixed(1)),
    );
  }
}
