import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';

class PaidOrdersScreen extends StatelessWidget {
  const PaidOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24, top: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Paid services', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 16),
              ...[
                {
                  'icon': '🧑‍🔧',
                  'service': 'Plumbing',
                  'amount': '\u0000300.00',
                  'date': 'December 24, 2023',
                  'name': 'Emily jani',
                },
                {
                  'icon': '🧑‍🎨',
                  'service': 'Painter',
                  'amount': '\u0000600.00',
                  'date': 'December 07, 2023',
                  'name': 'Lucas',
                },
              ].map((order) => Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: AppColors.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(order['icon']!, style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 8),
                          Text(order['service']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Amount to paid', style: TextStyle(fontSize: 14)),
                          Text(order['amount']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primaryColor)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Booking date', style: TextStyle(fontSize: 14)),
                          Text(order['date']!, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Plumber name', style: TextStyle(fontSize: 14)),
                          Text(order['name']!, style: const TextStyle(fontSize: 14, color: AppColors.primaryColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
} 