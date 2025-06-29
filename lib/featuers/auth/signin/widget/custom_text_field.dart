import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
    );
  }
}
