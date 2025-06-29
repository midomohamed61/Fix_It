import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/core/routing/routes.dart';
import 'package:fix_it/featuers/payment/payment_method_screen.dart';

class UnpaidOrdersScreen extends StatelessWidget {
  const UnpaidOrdersScreen({super.key});

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
              const Text('You have not paid yet for bellow service', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: AppColors.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text('🧑‍🔧', style: TextStyle(fontSize: 20)),
                          SizedBox(width: 8),
                          Text('Plumbing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Amount to pay', style: TextStyle(fontSize: 14)),
                          Text('\u0000200.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primaryColor)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Booking date', style: TextStyle(fontSize: 14)),
                          Text('December 23, 2023', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Plumber name', style: TextStyle(fontSize: 14)),
                          Text('Emily jani', style: TextStyle(fontSize: 14, color: AppColors.primaryColor)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: AppColors.backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.PaymentMethodScreen);
                          },
                          child: const Text('Pay now'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 