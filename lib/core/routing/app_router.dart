import 'package:fix_it/core/di/di.dart';
import 'package:fix_it/core/routing/routes.dart';
import 'package:fix_it/featuers/auth/account/cubit/service_type_cubit.dart';
import 'package:fix_it/featuers/auth/account/phone_verification_screen.dart';
import 'package:fix_it/featuers/auth/account/role_selection%20_screen.dart';
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
        case Routes.RoleSelectionScreen:
  return MaterialPageRoute(
    builder: (context) => BlocProvider(
      create: (context) => getIt<ServiceTypeCubit>(),
      child: const RoleSelectionScreen(),
    ),
  );

        case Routes.PhoneVerificationScreen:
  return MaterialPageRoute(
    builder: (_) => BlocProvider.value(
      value: getIt<SignupCubit>(),
      child: const PhoneVerificationScreen(),
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
