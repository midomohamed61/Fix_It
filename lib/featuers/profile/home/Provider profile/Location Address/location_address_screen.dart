import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class LocationAddressScreen extends StatefulWidget {
  const LocationAddressScreen({Key? key}) : super(key: key);

  @override
  State<LocationAddressScreen> createState() => _LocationAddressScreenState();
}

class _LocationAddressScreenState extends State<LocationAddressScreen> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessAddressController = TextEditingController();

  @override
  void dispose() {
    businessNameController.dispose();
    businessAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Image.asset('assets/images/Frame.png', height: 30),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Business Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please provide your business details to help clients find you easily.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: businessNameController,
              decoration: InputDecoration(
                hintText: "Business name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.business_outlined),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: businessAddressController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Business Address",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.location_city_outlined),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // هنا يمكنك إرسال البيانات أو الانتقال للخطوة التالية
                  Navigator.pushReplacementNamed(context, '/BottomNavBar');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1566C2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}