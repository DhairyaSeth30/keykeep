
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';


import '../model/PasswordModel.dart';


class ViewPassword extends StatefulWidget {

  final Password password;

  const ViewPassword({Key? key, required this.password}) : super(key: key);

  @override
  _ViewPasswordState createState() => _ViewPasswordState();
}

class _ViewPasswordState extends State<ViewPassword> {
  // final Password password;
  // _ViewPasswordState(this.password);

  TextEditingController masterPassController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool decrypt = false;
  String decrypted = " ";
  // late Color color;
  // late int index;
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 9), radix: 16) + 0xFF000000);
  }

  bool didAuthenticate = false;

  // authenticate() async {
  //   var localAuth = LocalAuthentication();
  //   didAuthenticate = await localAuth.authenticateWithBiometrics(
  //       localizedReason: 'Please authenticate to view password',
  //       stickyAuth: true);
  // }

  Future<String> getMasterPass() async {
    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    return masterPass;
  }

  @override
  void initState() {
    // print(widget.password.color);
    // color = hexToColor(widget.password.color.toString());
    // index = iconNames.indexOf(widget.password.icon.toString());
    // authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(widget.password.color!),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(widget.password.color!),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    IconData(
                      widget.password.icon!,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: Colors.white,
                    size: 72,
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.password.appName.toString(),
                    style: TextStyle(
                      fontFamily: "Title",
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSection(
                    "Username",
                    widget.password.userName!,
                    trailing: IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () {
                        // Implement copy functionality
                        Clipboard.setData(ClipboardData(text: widget.password.userName!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Username copied to clipboard'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    )
                  ),
                  buildSection(
                    "Password",
                    decrypt ? widget.password.password.toString() : "******",
                    trailing: IconButton(
                      icon: decrypt ? Icon(Icons.lock_open, color: Colors.green) : Icon(Icons.lock, color: Colors.red),
                      onPressed: () {
                        if (!decrypt && !didAuthenticate) {
                          // String masterPass = await getMasterPass();
                          buildShowDialogBox(context);
                          // decryptPass(widget.password.password.toString(), masterPass);
                        }
                        // else if (!decrypt && didAuthenticate) {
                        //   String masterPass = await getMasterPass();
                        //   decryptPass(widget.password.password.toString(), masterPass);
                        // }
                        else if (decrypt) {
                          setState(() {
                            decrypt = !decrypt;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      key: scaffoldKey,
// backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              height: size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(widget.password.color!),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      IconData(
                        widget.password.icon!, // The stored codePoint value
                        fontFamily: 'MaterialIcons', // Ensure this matches the icon set
                      ),
                      color: Colors.white,
                      size: 64,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                        widget.password.appName.toString(),
                        style: TextStyle(
                            fontFamily: "Title",
                            fontSize: 32,
                            color: Colors.white)),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Username",
                    style: TextStyle(fontFamily: 'Title', fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                  child: Text(
                    widget.password.userName.toString(),
                    style: TextStyle(
                      fontFamily: 'Subtitle',
                      fontSize: 20,
// color: Colors.black54
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Password",
                            style: TextStyle(fontFamily: 'Title', fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                          child: Text(
                            decrypt ? decrypted : widget.password.password.toString(),
                            style: TextStyle(
                              fontFamily: 'Subtitle',
                              fontSize: 20,
// color: Colors.black54
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        if (!decrypt && !didAuthenticate) {
                          buildShowDialogBox(context);
                        } else if (!decrypt && didAuthenticate) {
                          String masterPass = await getMasterPass();
                          decryptPass(widget.password.password.toString(), masterPass);
                        } else if (decrypt) {
                          setState(() {
                            decrypt = !decrypt;
                          });
                        }
                      },
                      icon: decrypt ? Icon(Icons.lock_open) : Icon(Icons.lock),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSection(String title, String content, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Title',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                content,
                style: TextStyle(
                  fontFamily: 'Subtitle',
                  fontSize: 18,
                  // color: Colors.black87,
                ),
              ),
            ],
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Future buildShowDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Master Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "To decrypt the password enter your master password:",
                style: TextStyle(fontFamily: 'Subtitle'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  maxLength: 32,
                  decoration: InputDecoration(
                      hintText: "Master Pass",
                      hintStyle: TextStyle(fontFamily: "Subtitle"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                  controller: masterPassController,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async{
                // print(masterPassController.text.trim());

                context.pop();
                String masterPass = await getMasterPass();
                // print("Master Password is : $masterPass");
                // decryptPass(widget.password.password.toString(), masterPassController.text.trim());
                decryptPass(masterPass, masterPassController.text.trim());
                masterPassController.clear();
                if (!decrypt) {
                  final snackBar = SnackBar(
                    content: Text(
                      'Wrong Master Password',
                      style: TextStyle(fontFamily: "Subtitle"),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text("DONE"),
            )
          ],
        );
      },
    );
  }

  // decryptPass(String encryptedPass, String masterPass) {
  //   String keyString = masterPass;
  //   if (keyString.length < 32) {
  //     int count = 32 - keyString.length;
  //     for (var i = 0; i < count; i++) {
  //       keyString += ".";
  //     }
  //   }
  //
  //   final iv = encrypt.IV.fromLength(16);
  //   final key = encrypt.Key.fromUtf8(keyString);
  //
  //   try {
  //     final encrypter = encrypt.Encrypter(encrypt.AES(key));
  //     final d = encrypter.decrypt64(encryptedPass, iv: iv);
  //     setState(() {
  //       decrypted = d;
  //       decrypt = true;
  //     });
  //   } catch (exception) {
  //     setState(() {
  //       decrypted = "Wrong Master Password";
  //     });
  //   }
  // }

  decryptPass(String enteredPass, String masterPass){

    if(enteredPass == masterPass){
      setState(() {
        decrypt = true;
      });

    }
  }


}
















//
// import 'package:flutter/material.dart';
//
// import '../model/PasswordModel.dart';
//
//
// class ViewPassword extends StatefulWidget {
//   final Password password;
//
//   const ViewPassword({Key? key, required this.password}) : super(key: key);
//
//   @override
//   State<ViewPassword> createState() => _ViewPasswordState();
// }
//
// class _ViewPasswordState extends State<ViewPassword> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.password.appName ?? 'Password Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('App Name: ${widget.password.appName ?? 'N/A'}', style: TextStyle(fontSize: 18)),
//             SizedBox(height: 8),
//             Text('Username: ${widget.password.userName ?? 'N/A'}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             Text('Password: ${widget.password.password ?? 'N/A'}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Text('Icon: '),
//                 Icon(
//                   IconData(
//                     widget.password.icon ?? Icons.help.codePoint,
//                     fontFamily: 'MaterialIcons',
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//             Container(
//               width: 24,
//               height: 24,
//               color: Color(widget.password.color ?? 0xFFFFFFFF),
//               child: const Center(child: Text('Color')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
