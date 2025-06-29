import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';

class ReviewSummaryScreen extends StatelessWidget {
  final String name;
  final String jobTitle;
  final double rate;
  final String? imageUrl;
  final String address;
  final String date;
  final String time;
  final double price; // السعر بالساعة
  final String availability; // المواعيد المتاحة
  const ReviewSummaryScreen({
    super.key, 
    required this.name, 
    required this.jobTitle, 
    required this.rate, 
    this.imageUrl, 
    required this.address, 
    required this.date, 
    required this.time,
    required this.price,
    required this.availability,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Summary", style: TextStyle(color: AppColors.textColor)),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Worker Info
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: imageUrl != null ? AssetImage(imageUrl!) : null,
                  child: imageUrl == null ? Icon(Icons.person, size: 40) : null,
                ),
                const SizedBox(width: 16),
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Service Info
            _buildInfoRow('Type', jobTitle),
            _buildInfoRow('Price', '\$${price.toStringAsFixed(0)}/H'),
            _buildInfoRow('Material', 'Not Included'),
            _buildInfoRow('Traveling', 'Free'),
            const SizedBox(height: 24),
            // Address Info
            const Text(
              'Address',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor),
            ),
            const SizedBox(height: 8),
            Text(
              address,
              style: TextStyle(color: AppColors.textColor),
            ),
            const SizedBox(height: 16),
            // Booking Info
            _buildInfoRow('Booking Date', date),
            _buildInfoRow('Booking Hours', time),
            _buildInfoRow('Availability', availability),
            const SizedBox(height: 16),
            // Total Info
            _buildInfoRow('Total', '\$${price.toStringAsFixed(0)}/H'),
            const SizedBox(height: 32),
            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  FakeOrderStore.paidOrders.add(FakeOrder(
                    service: jobTitle,
                    amount: '\$${price.toStringAsFixed(0)}',
                    date: date,
                    name: name,
                  ));
                  Navigator.pushReplacementNamed(context, '/PaidOrdersScreen');
                  Future.delayed(const Duration(milliseconds: 300), () {
                    _showConfirmationDialog(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Confirm', style: TextStyle(color: AppColors.backgroundColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor)),
          Text(value, style: TextStyle(color: AppColors.greyTextColor)),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.check_circle, color: AppColors.primaryColor, size: 40),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Order received',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Your order for booking the plumber has been received. The plumber will arrive at 10:00 AM.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/BottomNavBar');
              },
              child: const Text('Home', style: TextStyle(color: AppColors.primaryColor)),
            ),
          ],
        );
      },
    );
  }
}

class FakeOrder {
  final String service;
  final String amount;
  final String date;
  final String name;
  FakeOrder({required this.service, required this.amount, required this.date, required this.name});
}

class FakeOrderStore {
  static List<FakeOrder> paidOrders = [];
}


