import 'package:flutter/material.dart';

class AuthCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String logoPath;

  const AuthCustomAppBar({
    super.key,
    this.logoPath = 'assets/images/Frame.png', // المسار الافتراضي للوجو
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // ارتفاع ثابت للـ AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        logoPath,
        height: 30, // حجم اللوجو
      ),
    );
  }
}
