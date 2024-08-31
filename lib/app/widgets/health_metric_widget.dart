import 'package:flutter/material.dart';
import 'health_card_widget.dart';

class HealthMetricWidget extends StatelessWidget {
  final List<Map<String, String>> metrics;

  HealthMetricWidget({required this.metrics});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: metrics.map((metric) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: HealthCardWidget(
            title: metric['title']!,
            value: metric['value']!,
            color: Colors.teal,
          ),
        );
      }).toList(),
    );
  }
}
