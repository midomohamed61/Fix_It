import 'package:fix_it/core/di/di.dart';
import 'package:fix_it/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'featuers/BottomNavBar.dart';
import 'featuers/city/CityScreen.dart';
import 'featuers/profile/my_profile.dart';
import 'featuers/order/order_screen.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'featuers/home/HomeScreen.dart';
import 'featuers/payment/payment_method_screen.dart';
import 'package:fix_it/featuers/auth/signin/signinScreen.dart';
import 'package:fix_it/core/routing/routes.dart';
import 'featuers/splash/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt(); // خليه هنا بس
  runApp(const MyApp());
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    // يمكنك استبدال Container() بشاشتك الرئيسية لاحقًا
    HomeScreen(),
    CityScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: const BottomNavBar(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fix It',
        initialRoute: Routes.SplashScreen,
        onGenerateRoute: AppRouter().generateRoute,
      ),
    );
  }
}
