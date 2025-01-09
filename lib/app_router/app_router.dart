
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:keykeep/app_router/route_constants.dart';
import 'package:keykeep/pages/AddPasswordPage.dart';
import 'package:keykeep/pages/GreetingsPage.dart';
import 'package:keykeep/pages/SetMasterPassword.dart';
import 'package:keykeep/pages/SettingsPage.dart';
import 'package:keykeep/pages/ViewPasswordPage.dart';
import 'package:keykeep/pages/splash_screen.dart';

import '../model/PasswordModel.dart';
import '../pages/PasswordHomepage.dart';


final router = GoRouter(
  // initialLocation:  '/${Routes.greetingsPage}',
  initialLocation:  '/${Routes.splashScreen}',
  routes: [
    // GoRoute(
    //   name: Routes.splash,
    //   path: '/${Routes.splash}',
    //   builder: (context, state) => const SplashScreen(),
    // ),
    GoRoute(
      name: Routes.home,
      path: '/${Routes.home}',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      name: Routes.settings,
      path: '/${Routes.settings}',
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      name: Routes.splashScreen,
      path: '/${Routes.splashScreen}',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      name: Routes.greetingsPage,
      path: '/${Routes.greetingsPage}',
      builder: (context, state) => GreetingsPage(),
    ),
    GoRoute(
      name: Routes.setMasterPasswordScreen,
      path: '/${Routes.setMasterPasswordScreen}',
      builder: (context, state) => const SetMasterPassword(),
    ),
    GoRoute(
      path: '/addPasswordScreen',
      name: Routes.addPasswordScreen,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: PasswordManagerForm(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Slide from right
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      },
    ),

    GoRoute(
      name: Routes.viewPasswordPage,
      path: '/${Routes.viewPasswordPage}',
      builder: (context, state) {
        final password = state.extra as Password; // Cast the extra to a Password object
        return ViewPassword(password: password);
      },
    ),

  ],
);