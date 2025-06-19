import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/core/routing/routes.dart'; 

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) {

        if (index == 0) {
          //Navigator.pushNamed(context, Routes.HomeScreen);
        } else if (index == 1) {
          Navigator.pushNamed(context, Routes.CityScreen);
        } else if (index == 2) {
          //Navigator.pushNamed(context, Routes.OrderScreen);
        } else if (index == 3) {
          //Navigator.pushNamed(context, Routes.ProfileScreen);
        }
        widget.onTap(index);
      },
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