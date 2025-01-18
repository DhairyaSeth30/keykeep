
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keykeep/components/rounded_button.dart';
import 'package:keykeep/riverpod/provider.dart';

import '../model/PasswordModel.dart';
import '../riverpod/state.dart';
import 'package:uuid/uuid.dart';

import '../theme/theme_provider.dart';

class PasswordManagerForm extends ConsumerStatefulWidget {
  @override
  _PasswordManagerFormState createState() => _PasswordManagerFormState();
}

class _PasswordManagerFormState extends ConsumerState<PasswordManagerForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Color? pickedColor;
  late int pickedIcon;

  List<Icon> icons = [
    Icon(Icons.account_circle, size: 28, color: Colors.white),
    Icon(Icons.list_alt_rounded, size: 28, color: Colors.white),
    Icon(Icons.whatshot, size: 28, color: Colors.white),
    Icon(Icons.ac_unit, size: 28, color: Colors.white),
    Icon(Icons.privacy_tip_rounded, size: 28, color: Colors.white),
    Icon(Icons.account_balance, size: 28, color: Colors.white),
    Icon(Icons.add_circle_outline, size: 28, color: Colors.white),
    Icon(Icons.webhook_sharp, size: 28, color: Colors.white),
    Icon(Icons.dashboard_customize_rounded, size: 28, color: Colors.white),
    Icon(Icons.code, size: 28, color: Colors.white),
    Icon(Icons.telegram_rounded, size: 28, color: Colors.white),
    Icon(Icons.motion_photos_on_rounded, size: 28, color: Colors.white),
    Icon(Icons.key, size: 28, color: Colors.white),
    Icon(Icons.facebook_outlined, size: 28, color: Colors.white),
    Icon(Icons.assessment, size: 28, color: Colors.white),

  ];

  List<Color> colors = [
    Colors.red,
    // Color(0xffd5563a),
    Color(0xffcf5a3b),
    // Color(0xffca5d3c),
    // Color(0xffc6603d),
    // Color(0xffc0643d),
    Color(0xffba673e),
    // Color(0xffb66a3f),
    // Color(0xffb36c3f),
    // Color(0xffaf6e40),
    Color(0xffa87341),
    // Color(0xffa47642),
    Color(0xffa07842),
    // Color(0xff9b7b43),
    // Color(0xff967f44),
    // Color(0xff908245),
    Color(0xff8b8646),
    // Color(0xff858a47),
    Color(0xff808d47),
    // Color(0xff799249),
    // Color(0xff769349),
    // Color(0xff72964a),
    Color(0xff6d994a),
    // Color(0xff6c9a4a),
    // Color(0xff659e4c),
    // Color(0xff639f4c),
    Color(0xff5ea34d),
    // Color(0xff5ba44d),
    Color(0xff58a64e),
    // Color(0xff53aa4e),
    Colors.green
  ];

  @override
  void initState() {
    pickedColor = Colors.blue;
    // getMasterPass();
    pickedIcon = 0;
    // authenticate();
    super.initState();
  }

  Future<void> _saveProduct() async {
    String title = _titleController.text.trim();
    String username = _userNameController.text.trim();
    String password = _passwordController.text.trim();
    var uuid = Uuid();

    if (title.isEmpty || username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    // Create a new password
    Password newPassword = Password(
      // name: name,PasswordManagerForm
      // price: double.tryParse(price) ?? 0,
      // // imagePath: _image?.path,
      // imagePath: base64Image,
      id: uuid.v4(), // Generates a unique string ID
      icon: icons[pickedIcon].icon!.codePoint,
      color: pickedColor?.value,
      userName: username,
      appName: title,
      password: password, // Store the Base64 string
    );


    await ref.read(passwordNotifierProvider.notifier).addPassword(newPassword);

    final passwordState = ref.watch(passwordNotifierProvider);
    if (passwordState.status == DataStatus.error || passwordState.status == DataStatus.idle) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(passwordState.message ?? 'Error occurred')));
    } else {
      Navigator.pop(context, true);
    }
  }





  @override
  Widget build(BuildContext context) {
    final passwordState = ref.watch(passwordNotifierProvider); // Watch the form state
    //final formNotifier = ref.read(formNotifierProvider.notifier); // Access the notifier

    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: scaffoldKey,
      body: passwordState.status == DataStatus.loading
          ? Center(child: CircularProgressIndicator(),)
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      margin: EdgeInsets.only(top: size.height * 0.05),
                      child: Text(
                        "Add Password",
                        style: TextStyle(
                            fontFamily: "Title",
                            fontSize: 32,
                            color: isDarkMode ? Colors.white : primaryColor
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                              labelText: "Title",
                              labelStyle: TextStyle(fontFamily: "Subtitle"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          // Assign controller value from state
                          //onChanged: (value) => formNotifier.updateAppName(value),
                          //controller: TextEditingController(text: formState.appName),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _userNameController,
                          decoration: InputDecoration(
                              labelText: "User Name/Email (if available)",
                              labelStyle: TextStyle(fontFamily: "Subtitle"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          //onChanged: (value) => formNotifier.updateUserName(value),
                          //controller: TextEditingController(text: formState.userName),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _passwordController,
                          onChanged: (pass) {
                            // formNotifier.updatePassword(pass);
                            // formNotifier.checkPassStrength(pass);
                          },
                          // obscureText: formState.obscureText,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(fontFamily: "Subtitle"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          // controller: TextEditingController(text: formState.password),
                        ),
                      ),

                      // Padding(
                      //   padding: EdgeInsets.only(),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: <Widget>[
                      //       TextButton(
                      //         onPressed: () {
                      //           String pass = randomAlphaNumeric(10);
                      //           formNotifier.updatePassword(pass);
                      //           formNotifier.checkPassStrength(pass);
                      //         },
                      //         child: Text('Generate'),
                      //       ),
                      //       TextButton(
                      //         onPressed: () {
                      //           formNotifier.toggleObscureText();
                      //         },
                      //         child: Text(formState.obscureText ? 'Show Password' : 'Hide Password'),
                      //       ),
                      //       TextButton(
                      //         onPressed: () {
                      //           Clipboard.setData(
                      //             ClipboardData(text: formState.password),
                      //           );
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //             SnackBar(
                      //               content: Text("Copied to Clipboard"),
                      //               duration: Duration(seconds: 2),
                      //             ),
                      //           );
                      //         },
                      //         child: Text('Copy'),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 10, horizontal: 15),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Container(
                      //       height: 10,
                      //       width: formState.passwordStrength == 0
                      //           ? 5
                      //           : MediaQuery.of(context).size.width *
                      //           formState.passwordStrength,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         color: formState.passwordStrengthBarColor,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 8.0),
                              child: Text(
                                "Pick an Icon",
                                style: TextStyle(
                                    fontFamily: 'Title',
                                    fontSize: 20,
                                    color: isDarkMode ? Colors.white : primaryColor
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 8.0),
                              child: Material(
                                shape: CircleBorder(),
                                elevation: 4.0,
                                child: CircleAvatar(
                                  backgroundColor: pickedColor,
                                  radius: 25,
                                  child : icons[pickedIcon]
                                  // child: formState.icons[formState.pickedIcon]
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0, 24, 10),
                        child: GridView.count(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 5,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.3,
                            // children: List.generate(formState.icons.length, (index) {
                            children: List.generate(icons.length, (index) {
                              return InkWell(
                                onTap: () {
                                  // formNotifier.updatePickedIcon(index);
                                  setState(() {
                                    pickedIcon = index;
                                  });
                                },
                                child: Material(
                                    elevation: 4.0,
                                    color: pickedColor,
                                    shape: CircleBorder(),
                                    child: icons[index]),
                              );
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Pick a Color",
                                    style: TextStyle(
                                        fontFamily: 'Title',
                                        fontSize: 20,
                                        color: isDarkMode ? Colors.white : primaryColor
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _openColorPicker();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 8.0),
                                    child: Material(
                                        shape: CircleBorder(),
                                        elevation: 4.0,
                                        child: CircleAvatar(
                                          child: Icon(Icons.open_in_new_rounded, color: isDarkMode ? Colors.white : Colors.black),
                                          backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                                          radius: 25,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //   child: RoundedButton(title: 'Save', onPressed: (){}, textColor: Colors.black),
                      // )
                    ],
                  ),
                ],
              ),
            ),
        persistentFooterButtons: [
          Column(
            children: [
              RoundedButton(
                onPressed: () {
                  _saveProduct();
                },
                title: 'Save',
                textColor: Colors.white,
                filledColor : isDarkMode ? Colors.green : primaryColor
              ),
            ],
          ),
        ]
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: isDarkMode ? Colors.green : primaryColor,
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     // if (_formKey.currentState!.validate()) {
      //     //   _saveProduct();
      //     // }
      //     _saveProduct();
      //   },
      // ),
    );
  }

  _openColorPicker() async {
    Color? _tempShadeColor = pickedColor;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text("Color picker"),
          actions: [
            TextButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            TextButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  pickedColor = _tempShadeColor;
                });
              },
            ),
          ],
          content: MaterialColorPicker(
            allowShades: true,
            selectedColor: _tempShadeColor,
            onColorChange: (color) => setState(() => _tempShadeColor = color),
            onMainColorChange: (color) =>
                setState(() => _tempShadeColor = color),
          ),
        );
      },
    );
  }
}
