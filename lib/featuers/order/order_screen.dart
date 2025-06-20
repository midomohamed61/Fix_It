import 'package:flutter/material.dart';
import 'unpaid_orders.dart';
import 'paid_orders.dart';
import 'schedule_orders.dart';
import 'package:fix_it/core/themes/app_colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = ['Unpaid', 'Paid', 'Schedule'];
  final List<Widget> _tabScreens = const [
    UnpaidOrdersScreen(),
    PaidOrdersScreen(),
    ScheduleOrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primaryColor)),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  final isSelected = _selectedTab == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryColor : AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            _tabs[index],
                            style: TextStyle(
                              color: isSelected ? AppColors.backgroundColor : AppColors.greyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: _tabScreens[_selectedTab]),
          ],
        ),
      ),
    );
  }
} 