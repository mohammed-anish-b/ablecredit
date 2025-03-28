import 'package:ablecredit/models/car.dart';
import 'package:flutter/material.dart';

class CarItem extends StatelessWidget {
  final Car car;

  const CarItem({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              car.model,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Row(
              children: [
                const Icon(Icons.calendar_month_rounded, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "Year: ${car.year}",
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.tag, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "Vehicle Tag: ${car.vehicleTag}",
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
