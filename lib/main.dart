
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keykeep/pages/GreetingsPage.dart';
import 'package:keykeep/theme/theme_provider.dart';

import 'app_router/app_router.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Future.wait([
//     ScreenUtil.ensureScreenSize(),
//   ]);
//
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
//         (value) => runApp(ProviderScope(child: MyApp())),
//   );
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   int launch = 0;
//   bool loading = true;
//   int? primarycolorCode;
//   Color primaryColor = Color(0xff5153FF);
//
//   // checkPrimaryColr() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   primarycolorCode = prefs.getInt('primaryColor') ?? 0;
//   //
//   //   if (primarycolorCode != 0) {
//   //     setState(() {
//   //       // primaryColor = Color(primarycolorCode);
//   //     });
//   //   }
//   // }
//
//   // Future checkFirstSeen() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   launch = prefs.getInt("launch") ?? 0;
//   //
//   //   final storage = new FlutterSecureStorage();
//   //   String masterPass = await storage.read(key: 'master') ?? '';
//   //
//   //   if (prefs.getInt('primaryColor') == null) {
//   //     await prefs.setInt('primaryColor', 0);
//   //   }
//   //
//   //   if (launch == 0 && masterPass == '') {
//   //     await prefs.setInt('launch', launch + 1);
//   //     await prefs.setInt('primaryColor', 0);
//   //     // await prefs.setBool('enableDarkTheme', false);
//   //   }
//   //
//   //   setState(() {
//   //     loading = false;
//   //   });
//   // }
//
//   @override
//   void initState() {
//     // checkPrimaryColr();
//     // checkFirstSeen();
//     super.initState();
//   }
//
//   bool isDarkMode = false; // Track the current theme
//
//   @override
//   Widget build(BuildContext context) {
//     // checkPrimaryColr();
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Cipherly',
//       theme: ThemeData(
//         fontFamily: "Title",
//         primaryColor: primaryColor,
//         colorScheme: ColorScheme.fromSwatch().copyWith(
//           secondary: Color(0xff0029cb),
//         ),
//         brightness: Brightness.light, // Light theme settings
//       ),
//       // darkTheme: ThemeData(
//       //   fontFamily: "Title",
//       //   primaryColor: primaryColor,
//       //   colorScheme: ColorScheme.fromSwatch().copyWith(
//       //     secondary: Color(0xff0029cb),
//       //   ),
//       //   brightness: Brightness.dark, // Dark theme settings
//       // ),
//       // themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light, // Toggle theme
//       // home: loading
//       //     ? Center(
//       //   child: CircularProgressIndicator(),
//       // )
//       //     : launch == 0 ? GreetingsPage() : PasswordHomepage(),
//
//       home: GreetingsPage(),
//     );
//   }
// }




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
