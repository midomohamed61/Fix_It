import 'package:flutter/material.dart';

class AuthCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;
  final String logoPath;

  const AuthCustomAppBar({
    super.key,
    required this.onBack,
    this.logoPath = 'assets/images/Frame.png', // المسار الافتراضي للوجو
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // ارتفاع ثابت للـ AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBack,
      ),
      centerTitle: true,
      title: Image.asset(
        logoPath,
        height: 30, // حجم اللوجو
      ),
    );
  }
}
