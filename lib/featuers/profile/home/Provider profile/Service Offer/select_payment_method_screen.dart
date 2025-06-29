import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/featuers/home/worker_home_screen.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  State<SelectPaymentMethodScreen> createState() => _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  String? selectedMethod = 'Easypaisa';
  final List<Map<String, dynamic>> methods = [
    {'label': 'Easypaisa', 'icon': Icons.account_balance_wallet_outlined},
    {'label': 'Bank account', 'icon': Icons.account_balance},
    {'label': 'Jazz cash', 'icon': Icons.credit_card},
    {'label': 'PayPal', 'icon': Icons.account_balance_wallet},
  ];

  Future<void> _saveMethod() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('paymentMethod', selectedMethod ?? '');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment method saved locally!')));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF1566C2), size: 48),
              const SizedBox(height: 16),
              const Text('Application received', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              const Text(
                'Your application for the service of plumping has received, you will  get conformation message from our staff',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const WorkerHomeScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1566C2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Home', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Image.asset('assets/images/Frame.png', height: 30),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.more_horiz, color: Colors.blue[900]),
                Icon(Icons.more_horiz, color: Colors.blue[900]),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Payment method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ...methods.map((m) => _buildPaymentOption(m)).toList(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveMethod,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1566C2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(Map<String, dynamic> m) {
    final isSelected = selectedMethod == m['label'];
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = m['label']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: isSelected ? AppColors.primaryColor : Colors.grey[300]!, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(m['icon'], color: AppColors.primaryColor),
            const SizedBox(width: 12),
            Expanded(child: Text(m['label'], style: const TextStyle(fontSize: 15))),
            if (isSelected)
              const Icon(Icons.check, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
} 