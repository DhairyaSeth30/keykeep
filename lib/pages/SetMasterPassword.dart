
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../app_router/route_constants.dart';
import '../theme/theme_provider.dart';

class SetMasterPassword extends ConsumerStatefulWidget {
  const SetMasterPassword({super.key});
  @override
  _SetMasterPasswordState createState() => _SetMasterPasswordState();
}

class _SetMasterPasswordState extends ConsumerState<SetMasterPassword> {
  TextEditingController masterPassController = TextEditingController();

  Future<void> getMasterPass() async {

    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    // await storage.deleteAll();
    masterPassController.text = masterPass;

  }

  saveMasterPass(String masterPass) async{
    final storage = new FlutterSecureStorage();   

    await storage.write(key: 'master', value: masterPass);
  }

  // authenticate() async {
  //   var localAuth = LocalAuthentication();
  //   bool didAuthenticate = await localAuth.authenticate(
  //       localizedReason: 'Please authenticate to change master password',
  //       );
  //
  //   if (!didAuthenticate) {
  //     Navigator.pop(context);
  //   }
  //
  //   print(didAuthenticate);
  // }

  @override
  void initState() {
    super.initState();
    // authenticate();
    // getMasterPass();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Text("Master Password",
                    style: TextStyle(
                      fontFamily: "Title",
                      fontSize: 32,
                      color: isDarkMode ? Colors.white : primaryColor
                    ))),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  "Set Master Passwords for your all passwords. Keep your Master Password safe with you. This password will be used to unlock your encrypted passwords.",
                  style: TextStyle(
                      fontSize: 16,
                      // color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Subtitle"))),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                obscureText: true,
                maxLength: 32,
                decoration: InputDecoration(
                    labelText: "Master Pass",
                    labelStyle: TextStyle(fontFamily: "Subtitle"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
                controller: masterPassController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: size.width * 0.7,
                height: 60,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  color: isDarkMode ? Colors.green : primaryColor,
                  child: Text(
                    "CONFIRM",
                    style: TextStyle(color: Colors.white, fontFamily: "Title"),
                  ),
                  onPressed: () async {
                    if (masterPassController.text.isNotEmpty) {
                      saveMasterPass(masterPassController.text.trim());
                      await getMasterPass();
                      context.go('/${Routes.home}');
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Error!",
                                style: TextStyle(fontFamily: "Title"),
                              ),
                              content: Text(
                                "Please enter valid Master Password.",
                                style: TextStyle(fontFamily: "Subtitle"),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("CLOSE"),
                                  onPressed: () {
                                    context.pop();
                                  },
                                )
                              ],
                            );
                          });
                    }
                  },
                  // onPressed: (){
                  //   context.go('/${Routes.home}');
                  // },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
