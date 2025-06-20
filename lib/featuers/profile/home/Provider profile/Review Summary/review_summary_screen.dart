import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';

class ReviewSummaryScreen extends StatelessWidget {
  const ReviewSummaryScreen({super.key});

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
        child: FutureBuilder(
          future: _loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final data = snapshot.data as Map<String, String>;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Worker Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/Rectangle 2117.png'), // Replace with actual image
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Emily Jani',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Service Info
                _buildInfoRow('Type', 'Plumber'),
                _buildInfoRow('Price', '\$20/H'),
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
                  '${data['house_number']}, ${data['street_number']}, ${data['complete_address']}',
                  style: TextStyle(color: AppColors.textColor),
                ),
                const SizedBox(height: 16),
                // Booking Info
                _buildInfoRow('Booking Date', data['selected_date'] ?? 'N/A'),
                _buildInfoRow('Booking Hours', data['selected_time'] ?? 'N/A'),
                const SizedBox(height: 16),
                // Total Info
                _buildInfoRow('Total', '\$20/H'),
                const SizedBox(height: 32),
                // Confirm Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showConfirmationDialog(context);
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
            );
          },
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

  Future<Map<String, String>> _loadData() async {
    final houseNumber = await SharedPrefHelper.getString('house_number');
    final streetNumber = await SharedPrefHelper.getString('street_number');
    final completeAddress = await SharedPrefHelper.getString('complete_address');
    final selectedDate = await SharedPrefHelper.getString('selected_date');
    final selectedTime = await SharedPrefHelper.getString('selected_time');

    return {
      'house_number': houseNumber,
      'street_number': streetNumber,
      'complete_address': completeAddress,
      'selected_date': selectedDate,
      'selected_time': selectedTime,
    };
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
                Navigator.pushReplacementNamed(context, '/Home'); // Replace with your home route
              },
              child: const Text('Home', style: TextStyle(color: AppColors.primaryColor)),
            ),
          ],
        );
      },
    );
  }
}


