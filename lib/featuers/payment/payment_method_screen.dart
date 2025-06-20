import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/featuers/payment/add_card_screen.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/featuers/feedback/feedback_screen.dart';
import 'package:fix_it/featuers/home/HomeScreen.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _selectedIndex = 0;
  List<String> _savedCards = [];

  final List<Map<String, dynamic>> _methods = [
    {'icon': Icons.account_balance_wallet, 'label': 'Easypaisa'},
    {'icon': Icons.account_balance, 'label': 'Bank account'},
    {'icon': Icons.vpn_key, 'label': 'Jazz cash'},
    {'icon': Icons.paypal, 'label': 'PayPal'},
  ];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    List<String> cards = await SharedPrefHelper.getStringList('cards');
    setState(() {
      _savedCards = cards;
    });
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.check, color: Colors.white, size: 40),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Payment successful',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Payment of Plumber service\n\$200.00 has paid successfully',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pop(0); // Pop to MainScreen and send index 0
                  },
                  child: const Text('Home'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                  );
                },
                child: const Text('Give Feedback', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> allOptions = [
      ..._methods.map((m) => {'icon': m['icon'], 'label': m['label']}),
      ..._savedCards.map((c) => {'icon': Icons.credit_card, 'label': c}),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Payment', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Payment method', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              const SizedBox(height: 16),
              ...List.generate(allOptions.length, (index) {
                return _PaymentOption(
                  icon: allOptions[index]['icon'],
                  label: allOptions[index]['label'],
                  selected: _selectedIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                );
              }),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: const BorderSide(color: AppColors.primaryColor),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddCardScreen()),
                    );
                    if (result == true) {
                      _loadCards();
                    }
                  },
                  child: const Text('+ Add new card'),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.backgroundColor,
                  ),
                  onPressed: () {
                    _showPaymentSuccessDialog(context);
                  },
                  child: const Text('Pay \$200.00'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  const _PaymentOption({required this.icon, required this.label, this.selected = false, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: selected ? AppColors.primaryColor.withOpacity(0.1) : AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: selected ? AppColors.primaryColor : AppColors.borderColor),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryColor),
        title: Text(label, style: TextStyle(color: AppColors.textColor)),
        trailing: selected ? const Icon(Icons.check_circle, color: AppColors.primaryColor) : null,
        onTap: onTap,
      ),
    );
  }
} 