import 'package:fix_it/core/di/di.dart';
import 'package:fix_it/core/routing/routes.dart';
import 'package:fix_it/featuers/auth/signin/cubit/cubit/signin_cubit.dart';
import 'package:fix_it/featuers/auth/signin/signinScreen.dart';
import 'package:fix_it/featuers/auth/signup/cubit/cubit/signup_cubit.dart';
import 'package:fix_it/featuers/auth/signup/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Routes.SigninScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SigninCubit>(),
            child: SignInScreen(),
          ),
        );
      case Routes.SignupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignUpScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${setting.name}"),
            ),
          ),
        );
    }
  }
}
