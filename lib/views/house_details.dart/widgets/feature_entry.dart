import 'package:flutter/material.dart';

class FeatureEntry extends StatelessWidget {
  const FeatureEntry({required this.title, required this.subtitle, super.key});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
