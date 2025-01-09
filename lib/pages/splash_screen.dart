import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GreetingsPage.dart';
import 'PasswordHomepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  int launch = 0;
  bool loading = true;

  Future checkFirstSeen() async {
    // print('Inside splash screen');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? it = prefs.getInt("launch");
    // print('Here is the value $it');
    launch = prefs.getInt("launch") ?? 0;
    // print("value of launch is $launch");
    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    if (prefs.getInt('primaryColor') == null) {
      await prefs.setInt('primaryColor', 0);
    }

    if (launch == 0 && masterPass == '') {
      await prefs.setInt('launch', launch + 1);
      // await prefs.setInt('primaryColor', 0);
      // await prefs.setBool('enableDarkTheme', false);
    }

    // done this to make launch 0, to navigate to greetings page
    // await prefs.setInt('launch', 0);
    // print("value of launch is $launch");

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // _checkLoginStatus();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading ? CircularProgressIndicator() : launch == 0 ? GreetingsPage() : HomePage(),
      ),
    );
  }
}
