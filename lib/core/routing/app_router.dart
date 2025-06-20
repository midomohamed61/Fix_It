import 'package:fix_it/core/di/di.dart';
import 'package:fix_it/core/routing/routes.dart';
import 'package:fix_it/featuers/auth/account/cubit/service_type_cubit.dart';
import 'package:fix_it/featuers/auth/account/phone_verification_screen.dart';
import 'package:fix_it/featuers/auth/account/role_selection%20_screen.dart';
import 'package:fix_it/featuers/auth/signin/cubit/cubit/signin_cubit.dart';
import 'package:fix_it/featuers/auth/signin/signinScreen.dart';
import 'package:fix_it/featuers/auth/signup/cubit/cubit/signup_cubit.dart';
import 'package:fix_it/featuers/auth/signup/signupScreen.dart';
import 'package:fix_it/featuers/profile/edit_profile.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/CallScreen/call_screen.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/Date%20Time%20Selection/date_time_selection_screen.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/Gallery/gallery_screen%20.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/Location%20Address/location_address_screen.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/Location%20Permission/location_permission_screen.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/Review%20Summary/review_summary_screen.dart';
import 'package:fix_it/featuers/profile/home/Provider%20profile/provider_profile_screen.dart';
import 'package:fix_it/featuers/profile/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fix_it/featuers/BottomNavBar.dart';
import 'package:fix_it/featuers/city/CityScreen.dart';
import 'package:fix_it/featuers/order/order_screen.dart';
import 'package:fix_it/featuers/payment/payment_method_screen.dart';


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

       case Routes.ServiceSeekerProfile:
  return MaterialPageRoute(
    builder: (_) => BlocProvider.value(
      value: getIt<SignupCubit>(),
      child: const ProfileScreen(),
    ),
  );

  case Routes.EditProfileScreen: // 👈 ضيف الـ case بتاع EditProfile
        return MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
        );

      case Routes.ProviderProfileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProviderProfileScreen(),
        );

        case Routes.LocationPermissionScreen:
        return MaterialPageRoute(
          builder: (_) =>  LocationPermissionScreen(),
        );

        case Routes.LocationAddressScreen:
        return MaterialPageRoute(
          builder: (_) =>  LocationAddressScreen(),
        );

        case Routes.DateTimeSelectionScreen:
        return MaterialPageRoute(
          builder: (_) =>  DateTimeSelectionScreen(),
        );

        case Routes.ReviewSummaryScreen:
        return MaterialPageRoute(
          builder: (_) =>  ReviewSummaryScreen(),
        );

        case Routes.GalleryScreen:
        return MaterialPageRoute(
          builder: (_) =>  GalleryScreen(),
        );

        case Routes.CallScreen:
        return MaterialPageRoute(
          builder: (_) => const CallScreen(),
        );
        case Routes.BottomNavBar:
        return MaterialPageRoute(
          builder: (_) => BottomNavBar(
            currentIndex: 0,
            onTap: (index) {},
          ),
        );
        case Routes.CityScreen:
        return MaterialPageRoute(
          builder: (_) => const CityScreen(),
        );
        case Routes.OrderScreen:
          return MaterialPageRoute(
            builder: (_) => const OrderScreen(),
          );
        case Routes.PaymentMethodScreen:
          return MaterialPageRoute(
            builder: (_) => const PaymentMethodScreen(),
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
