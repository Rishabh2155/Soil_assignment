import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';
import '../models/reading.dart';
import 'auth_provider.dart';

final readingsStreamProvider =
StreamProvider.autoDispose<List<Reading>>((ref) {
  final svc = ref.watch(firebaseServiceProvider);
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return const Stream.empty();
  return svc.readingsStream(user.uid);
});

final latestReadingProvider = FutureProvider.autoDispose<Reading?>((ref) async {
  final svc = ref.watch(firebaseServiceProvider);
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return null;
  return svc.latestReading(user.uid);
});
