import 'package:fix_it/core/routing/routes.dart';
import 'package:fix_it/featuers/auth/signin/signinScreen.dart';
import 'package:fix_it/featuers/auth/signup/signupScreen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings stteting){
    switch(stteting.name){
      case  Routes.SigninScreen :
        return MaterialPageRoute(
          builder: (context) =>  SigninScreen()
        );
      case  Routes.SignupScreen :
        return MaterialPageRoute(
          builder: (context) =>  SignupScreen()
        );
        default:
          return null;
    }
  }
}