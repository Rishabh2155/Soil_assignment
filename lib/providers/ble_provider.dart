import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/bluetooth_service.dart';

final bleServiceProvider = Provider<BluetoothService>((ref) {
  // Swap to real BLE service later if needed
  return MockBluetoothService();
});

final bleConnectionProvider = StateProvider<bool>((ref) => false);
