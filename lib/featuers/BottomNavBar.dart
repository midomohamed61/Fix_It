import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'home/HomeScreen.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> _screens = const [
    HomeScreen(),
    // أضف الشاشات الأخرى هنا مثل CityScreen, OrderScreen, ProfileScreen
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor, // اللون الأزرق للأيقونة المختارة
      unselectedItemColor: AppColors.greyTextColor, // لون الأيقونات غير المختارة
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_city_outlined),
          activeIcon: Icon(Icons.location_city, color: Colors.blue),
          label: 'City',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: 'Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}