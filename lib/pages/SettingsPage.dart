
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app_router/route_constants.dart';
import '../theme/theme_provider.dart';
import 'SetMasterPassword.dart';

class SettingsPage extends ConsumerStatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  // SharedPreferences prefs;
  Color selectedColor = Colors.red;

  /*openSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (Color(prefs.getInt('primaryColor')) == null) {
        selectedColor = Color(0xff5153FF);
      } else {
        selectedColor = Color(prefs.getInt('primaryColor'));
      }
    });
  }*/

  @override
  void initState() {
    // openSharedPreferences();
    super.initState();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  late Color pickedColor;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            context.pop();
          },
            child: Icon(
                Icons.arrow_back_rounded,
              color: isDarkMode ? Colors.white : primaryColor,
            )),
        title: Text("Settings",
            style: TextStyle(
                fontFamily: "Title",
                fontSize: 25,
                color: isDarkMode ? Colors.white : primaryColor)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Container(
          //       // margin: EdgeInsets.only(top: size.height * 0.05),
          //       child: Text("Settings",
          //           style: TextStyle(
          //               fontFamily: "Title",
          //               fontSize: 32,
          //               color: isDarkMode ? Colors.white : primaryColor))),
          // ),
          InkWell(
            onTap: () {
              context.push('/${Routes.setMasterPasswordScreen}');
            },
            child: ListTile(
              leading: Icon(Icons.change_circle_rounded),
              title: Text(
                "Change Master Password",
                style: TextStyle(
                  fontFamily: 'Title',
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0), // Adjust horizontal padding
            ),
          ),
          // Column(
          //   children: <Widget>[
          //     ListTile(
          //       title: Text(
          //         "Accent Color",
          //         style: TextStyle(
          //           fontFamily: 'Title',
          //         ),
          //       ),
          //       subtitle: Text(
          //         "Change Accent Color",
          //         style: TextStyle(
          //           fontFamily: 'Subtitle',
          //         ),
          //       ),
          //     ),
          //     MaterialColorPicker(
          //       onColorChange: (Color color) {
          //         // pickedColor = color;
          //         // changeColor(color);
          //         // setState(() {
          //         //   selectedColor = color;
          //         // });
          //       },
          //       circleSize: 60,
          //       selectedColor: selectedColor,
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  void changeColor(Color color) {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt('primaryColor', color.value);
    //
    // DynamicTheme.of(context).setThemeData(new ThemeData().copyWith(
    //   primaryColor: color,
    // ));
  }
}
