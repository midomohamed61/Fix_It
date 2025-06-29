import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ScheduleOrdersScreen extends StatelessWidget {
  const ScheduleOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> orders = [
      {
        'icon': '🧑‍🔧',
        'service': 'Plumbing',
        'amount': '\u002430/H',
        'date': 'January 04, 2024',
        'time': '10:00AM',
        'name': 'Emily jani',
      },
      {
        'icon': '🧑‍🔒',
        'service': 'Locksmith',
        'amount': '\u002420/H',
        'date': 'January 04, 2024',
        'time': '10:00AM',
        'name': 'Benjamin',
      },
    ];
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24, top: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Upcoming Booking services', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 16),
              ...orders.map((order) => Card(
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
                          const Text('Amount to Pay', style: TextStyle(fontSize: 14)),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Arrival time', style: TextStyle(fontSize: 14)),
                          Text(order['time']!, style: const TextStyle(fontSize: 14)),
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
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryColor,
                            side: const BorderSide(color: AppColors.primaryColor),
                          ),
                          onPressed: () {},
                          child: const Text('Cancel Booking'),
                        ),
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