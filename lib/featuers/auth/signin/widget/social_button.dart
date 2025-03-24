import 'package:fix_it/core/themes/app_colors.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // بدل Expanded جوه
      height: 50, // حجم موحد
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: AppColors.greyTextColor,
          foregroundColor: AppColors.textColor,
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(text),
      ),
    );
  }
}
