import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !_isVisible,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(_isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => _isVisible = !_isVisible),
        ),
        hintText: "Enter your password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: widget.validator,
    );
  }
}
