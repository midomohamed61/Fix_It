import 'package:fix_it/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const InfoCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Icon(icon, size: 28, color: AppColors.primaryColor),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor)),
          Text(label, style: const TextStyle(color: AppColors.greyTextColor)),
        ],
      ),
    );
  }
}
