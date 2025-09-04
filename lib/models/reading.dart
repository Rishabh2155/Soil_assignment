import 'package:cloud_firestore/cloud_firestore.dart';

class Reading {
  final DateTime timestamp;
  final double temperatureC;
  final double moisturePct;

  Reading({
    required this.timestamp,
    required this.temperatureC,
    required this.moisturePct,
  });

  Map<String, dynamic> toMap() => {
    'timestamp': Timestamp.fromDate(timestamp),
    'temperature': temperatureC,
    'moisture': moisturePct,
  };

  factory Reading.fromMap(Map<String, dynamic> map) {
    final ts = map['timestamp'];
    DateTime dt;
    if (ts is Timestamp) {
      dt = ts.toDate();
    } else if (ts is DateTime) {
      dt = ts;
    } else {
      dt = DateTime.now();
    }
    return Reading(
      timestamp: dt,
      temperatureC: (map['temperature'] as num).toDouble(),
      moisturePct: (map['moisture'] as num).toDouble(),
    );
  }
}
