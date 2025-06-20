import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/core/helpers/shared_pref_helper.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    cardHolderController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add new card', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select your payment method', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Card'),
                value: 'Credit card',
                items: const [
                  DropdownMenuItem(value: 'Credit card', child: Text('Credit card')),
                  DropdownMenuItem(value: 'Debit card', child: Text('Debit card')),
                ],
                onChanged: (v) {},
              ),
              const SizedBox(height: 16),
              TextField(
                controller: cardNumberController,
                decoration: const InputDecoration(labelText: 'Card number', hintText: 'Enter 14 digit number'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: cardHolderController,
                decoration: const InputDecoration(labelText: 'Card holder name', hintText: 'Enter name'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: expiryController,
                      decoration: const InputDecoration(labelText: 'Card expiry date', hintText: 'DD/MM/YYYY'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: cvvController,
                      decoration: const InputDecoration(labelText: 'CVV', hintText: '0000'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.backgroundColor,
                  ),
                  onPressed: () async {
                    String cardNumber = cardNumberController.text;
                    if (cardNumber.length >= 4) {
                      String last4 = cardNumber.substring(cardNumber.length - 4);
                      String cardLabel = '**** **** **** $last4';
                      List<String> cards = await SharedPrefHelper.getStringList('cards');
                      cards.add(cardLabel);
                      await SharedPrefHelper.setStringList('cards', cards);
                      Navigator.pop(context, true);
                    }
                  },
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 