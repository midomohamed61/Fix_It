import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:fix_it/featuers/auth/signup/cubit/cubit/signup_cubit.dart';
import 'package:fix_it/core/networking/api_result.dart';
import 'dart:async';
import 'package:fix_it/featuers/city/CityScreen.dart';
import 'package:fix_it/featuers/profile/home/Provider profile/Location Address/location_address_screen.dart';
import 'package:fix_it/featuers/BottomNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String email;
  const PhoneVerificationScreen({super.key, required this.email});

  @override
  State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  int _seconds = 60;
  Timer? _timer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() => _seconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  void _verifyCode() async {
    print('Start verify: email=${widget.email}, code=${_pinController.text}');
    setState(() => _isLoading = true);
    final cubit = context.read<SignupCubit>();
    final result = await cubit.activateAccount(widget.email, _pinController.text);
    setState(() => _isLoading = false);
    print('Activation result: $result');
    if (result is Success) {
      print('Activation success, checking user role');
      
      // Check the saved user role
      final prefs = await SharedPreferences.getInstance();
      final userRole = prefs.getString('user_role') ?? 'customer';
      
      if (userRole == 'worker') {
        // For workers, continue to location address screen
        print('User is worker, navigating to LocationAddressScreen');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LocationAddressScreen(
              name: 'Jackson',
              jobTitle: 'Electrician',
              rate: 4.9,
              imageUrl: 'assets/images/worker1.png',
              price: 75.0,
              availability: '9:00 AM - 6:00 PM',
            ),
          ),
        );
      } else {
        // For customers, go directly to bottom nav bar
        print('User is customer, navigating to BottomNavBar');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const BottomNavBar(),
          ),
        );
      }
    } else if (result is Failure) {
      print('Activation failed: ${(result as Failure).errorHandler.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text((result as Failure).errorHandler.message ?? 'Activation failed')),
      );
    }
  }

  void _resendCode() {
    // TODO: استدعاء API لإعادة إرسال الكود إذا توفر
    _startTimer();
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Enter 5-digit PIN code sent to your phone number",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _pinController,
              maxLength: 5,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 16),
              decoration: const InputDecoration(
                counterText: "",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1566C2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Verify", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_seconds',
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                const Text('Did not received code?'),
                TextButton(
                  onPressed: _seconds == 0 ? _resendCode : null,
                  child: const Text('send again', style: TextStyle(color: Color(0xFF1566C2))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
