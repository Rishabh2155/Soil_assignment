import 'package:flutter/material.dart';
import '../models/reading.dart';

class ReadingCard extends StatelessWidget {
  final Reading reading;
  const ReadingCard({super.key, required this.reading});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.thermostat, color: Colors.red.shade400),
            const SizedBox(width: 8),
            Text('${reading.temperatureC}°C',
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(width: 24),
            Icon(Icons.water_drop, color: Colors.blue.shade400),
            const SizedBox(width: 8),
            Text('${reading.moisturePct}%',
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
