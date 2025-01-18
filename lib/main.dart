

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keykeep/pages/GreetingsPage.dart';
import 'package:keykeep/theme/theme_provider.dart';

import 'app_router/app_router.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    ScreenUtil.ensureScreenSize(),
  ]);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
        (value) => runApp(const ProviderScope(child: MyApp())),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return ScreenUtilInit(
      splitScreenMode: true,
      ensureScreenSize: false, // Set to false as ensureScreenSize is called in main
      child: MaterialApp.router(
        routerConfig: router,
        title: 'KeyKeep',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
