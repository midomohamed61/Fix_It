import 'package:fix_it/core/di/di.dart';
import 'package:fix_it/core/routing/app_router.dart';
import 'package:fix_it/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt(); // خليه هنا بس
  runApp(const MyApp());
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
        home: child,
        initialRoute: Routes.SigninScreen,
        onGenerateRoute: AppRouter().generateRoute,
      ),
    );
  }
}
