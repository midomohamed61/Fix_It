import 'package:fix_it/core/helpers/shared_pref_helper.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter/material.dart';


class LocationAddressScreen extends StatefulWidget {
  const LocationAddressScreen({super.key});

  @override
  _LocationAddressScreenState createState() => _LocationAddressScreenState();
}

class _LocationAddressScreenState extends State<LocationAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _streetNumberController = TextEditingController();
  final TextEditingController _completeAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedAddress(); // استرجاع العنوان المحفوظ عند بدء الشاشة
  }

  // استرجاع العنوان المحفوظ باستخدام SharedPrefHelper
  Future<void> _loadSavedAddress() async {
    final houseNumber = await SharedPrefHelper.getString('house_number');
    final streetNumber = await SharedPrefHelper.getString('street_number');
    final completeAddress = await SharedPrefHelper.getString('complete_address');
    setState(() {
      _houseNumberController.text = houseNumber;
      _streetNumberController.text = streetNumber;
      _completeAddressController.text = completeAddress;
    });
  }

  @override
  void dispose() {
    _houseNumberController.dispose();
    _streetNumberController.dispose();
    _completeAddressController.dispose();
    super.dispose();
  }

  // المنطق لحفظ العنوان و الانتقال للشاشة التالية
  void _handleNext() {
    if (_formKey.currentState!.validate()) {
      // حفظ العنوان باستخدام SharedPrefHelper
      Future.wait([
        SharedPrefHelper.setData<String>('house_number', _houseNumberController.text),
        SharedPrefHelper.setData<String>('street_number', _streetNumberController.text),
        SharedPrefHelper.setData<String>('complete_address', _completeAddressController.text),
      ]).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Address saved successfully')),
        );
        Navigator.pushReplacementNamed(context, '/DateTimeSelectionScreen');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () {
             Navigator.pushNamed(context, '/ProviderLocationPermissionScreen');
          },
        ),
        title: Text(
          'Plumber booking',
          style: TextStyle(color: AppColors.textColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your location address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 16),

              // House Number
              Text(
                'House number',
                style: TextStyle(fontSize: 14, color: AppColors.textColor),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _houseNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Enter house number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter house number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Street Number
              Text(
                'Street number',
                style: TextStyle(fontSize: 14, color: AppColors.textColor),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _streetNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Enter street number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter street number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Complete Address
              Text(
                'Complete Address',
                style: TextStyle(fontSize: 14, color: AppColors.textColor),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _completeAddressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Enter street number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter complete address';
                  }
                  return null;
                },
              ),
              Spacer(),

              // زر Next
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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