import 'package:flutter/material.dart';

class PopularServicesScreen extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> categories;

  const PopularServicesScreen({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular services')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: categories.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: entry.value.map((service) {
                  return SizedBox(
                    width: 90,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(service['icon'] as IconData, size: 32, color: Colors.blueAccent),
                            const SizedBox(height: 8),
                            Text(service['label'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
} 