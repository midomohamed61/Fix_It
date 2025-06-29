import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'home/HomeScreen.dart';
import 'home/worker_home_screen.dart';
import 'city/CityScreen.dart';
import 'order/order_screen.dart';
import 'profile/my_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chatbot/chatbot_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  List<Widget> _screens = [];
  bool _isCustomer = true;

  @override
  void initState() {
    super.initState();
    _loadScreens();
  }

  Future<void> _loadScreens() async {
    final prefs = await SharedPreferences.getInstance();
    final userRole = prefs.getString('user_role') ?? 'customer';
    
    setState(() {
      _isCustomer = userRole == 'customer' || userRole == 'user';
      
      if (userRole == 'worker') {
        _screens = [
          const WorkerHomeScreen(),
          const CityScreen(),
          const OrderScreen(),
          const ProfileScreen(),
          ChatbotScreen(onTabChanged: _changeTab),
        ];
      } else {
        _screens = [
          const HomeScreen(),
          const CityScreen(),
          const OrderScreen(),
          const ProfileScreen(),
          ChatbotScreen(onTabChanged: _changeTab),
        ];
      }
    });
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.isNotEmpty ? _screens[_currentIndex] : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.greyTextColor,
        showUnselectedLabels: true,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.location_city_outlined),
            label: 'City',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Order',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}