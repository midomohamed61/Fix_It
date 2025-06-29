import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckboxRow extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;

  const CustomCheckboxRow({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        const Text.rich(
          TextSpan(
            text: "I Agree With FixIt’s ",
            children: [
              TextSpan(
                text: "Term & Conditions",
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
