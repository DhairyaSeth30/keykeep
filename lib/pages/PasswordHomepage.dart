import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app_router/route_constants.dart';
import '../riverpod/provider.dart';
import '../riverpod/state.dart';
import '../theme/theme_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  // const HomePage({super.key, this.brigntness});
  HomePage({this.brigntness});

  @override
  _HomePageState createState() => _HomePageState();

  Brightness? brigntness = Brightness.light;
}

class _HomePageState extends ConsumerState<HomePage> {
  int? pickedIcon;

  List<Icon> icons = [
    Icon(Icons.account_circle, size: 28, color: Colors.white),
    Icon(Icons.add, size: 28, color: Colors.white),
    Icon(Icons.access_alarms, size: 28, color: Colors.white),
    Icon(Icons.ac_unit, size: 28, color: Colors.white),
    Icon(Icons.accessible, size: 28, color: Colors.white),
    Icon(Icons.account_balance, size: 28, color: Colors.white),
    Icon(Icons.add_circle_outline, size: 28, color: Colors.white),
    Icon(Icons.airline_seat_individual_suite, size: 28, color: Colors.white),
    Icon(Icons.arrow_drop_down_circle, size: 28, color: Colors.white),
    Icon(Icons.assessment, size: 28, color: Colors.white),
  ];

  List<String> iconNames = [
    "Icon 1",
    "Icon 2",
    "Icon 3",
    "Icon 4",
    "Icon 5",
    "Icon 6",
    "Icon 7",
    "Icon 8",
    "Icon 9",
    "Icon 10",
  ];

  // final bloc = PasswordBloc();

  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    super
        .initState(); // Use this to delay the provider modification until after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(passwordNotifierProvider.notifier).loadProducts();
    });

  }



  @override
  void dispose() {
    // bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(passwordNotifierProvider);

    // final themeModeNotifier = ref.read(themeModeProvider.notifier);
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "KeyKeep",
                      style: TextStyle(
                          fontFamily: "Title",
                          fontSize: 32,
                          color: isDarkMode ? Colors.white : primaryColor),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            isDarkMode
                                ? Icons.dark_mode_rounded
                                : Icons.wb_sunny,
                            // color: Theme.of(context).iconTheme.color,
                            color: isDarkMode ? Colors.white : primaryColor,
                          ),
                          // onPressed: themeModeNotifier.toggleTheme,
                          onPressed:
                              ref.read(themeModeProvider.notifier).toggleTheme,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: isDarkMode ? Colors.white : primaryColor,
                          ),
                          onPressed: () {
                            context.push('/${Routes.settings}');
                          },
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          // Expanded(
          //   child: StreamBuilder<List<Password>>(
          //     stream: bloc.passwords,
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       if (snapshot.hasData) {
          //         if (snapshot.data.length > 0) {
          //           return ListView.builder(
          //             itemCount: snapshot.data.length,
          //             itemBuilder: (BuildContext context, int index) {
          //               Password password = snapshot.data[index];
          //               int i = 0;
          //               i = iconNames.indexOf(password.icon.toString());// TODO: Watch here if error
          //               Color color = hexToColor(password.color.toString());// TODO: Watch here if error
          //               return Dismissible(
          //                 key: ObjectKey(password.id),
          //                 onDismissed: (direction) {
          //                   // var item = password;
          //                   // //To delete
          //                   // DBProvider.db.deletePassword(item.id);
          //                   // setState(() {
          //                   //   snapshot.data.removeAt(index);
          //                   // });
          //                   // //To show a snackbar with the UNDO button
          //                   // Scaffold.of(context).showSnackBar(SnackBar(
          //                   //     content: Text("Password deleted"),
          //                   //     action: SnackBarAction(
          //                   //         label: "UNDO",
          //                   //         onPressed: () {
          //                   //           DBProvider.db.newPassword(item);
          //                   //           setState(() {
          //                   //             snapshot.data.insert(index, item);
          //                   //           });
          //                   //         })));
          //                 },
          //                 child: InkWell(
          //                   onTap: () {
          //                     Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (BuildContext context) =>
          //                                 ViewPassword(
          //                                   password: password,
          //                                 )));
          //                   },
          //                   child: ListTile(
          //                     title: Text(
          //                       password.appName.toString(),
          //                       style: TextStyle(
          //                         fontFamily: 'Title',
          //                       ),
          //                     ),
          //                     leading: Container(
          //                         height: 48,
          //                         width: 48,
          //                         child: CircleAvatar(
          //                             backgroundColor: color, child: icons[i])),
          //                     subtitle: password.userName != ""
          //                         ? Text(
          //                             password.userName.toString(),
          //                             style: TextStyle(
          //                               fontFamily: 'Subtitle',
          //                             ),
          //                           )
          //                         : Text(
          //                             "No username specified",
          //                             style: TextStyle(
          //                               fontFamily: 'Subtitle',
          //                             ),
          //                           ),
          //                   ),
          //                 ),
          //               );
          //             },
          //           );
          //         } else {
          //           return Center(
          //             child: Text(
          //               "No Passwords Saved. \nClick \"+\" button to add a password",
          //               textAlign: TextAlign.center,
          //               // style: TextStyle(color: Colors.black54),
          //             ),
          //           );
          //         }
          //       } else {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //     },
          //   ),
          // ),

          Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: TextField(
                controller: _searchController,
                // focusNode: _focusNode,
                // showCursor:
                //     isKeyboardOpen,
                decoration: InputDecoration(
                  hintText: 'Search password',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey // Change border color
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey, // Set border color when focused
                    ),
                  ),
                ),
                onChanged: (query) {
                  ref.read(passwordNotifierProvider.notifier).searchProducts(query);
                },
              )),

          Expanded(
              child: productState.status == DataStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : productState.status == DataStatus.error
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  'Error: ${productState.message ?? 'Unknown error'}'),
                              ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(passwordNotifierProvider.notifier)
                                      .loadProducts();
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        )
                      : productState.data == null || productState.data!.isEmpty
                          ? const Center(child: Text('No Password Found'))
                          : ListView.builder(
                              itemCount: productState.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final password = productState.data![index];
                                int i = 0;
                                i = iconNames.indexOf(password.icon
                                    .toString()); // TODO: Watch here if error
                                if (i == -1) {
                                  i = 0; // Choose a safe default or handle gracefully
                                }
                                Color color = hexToColor(password.color
                                    .toString()); // TODO: Watch here if error
                                return InkWell(
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Want to Delete?"),
                                            content: Text(
                                                'Do you really want to delete ' +
                                                    password.appName! +
                                                    ' password ?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  context.pop();
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {

                                                  ref
                                                      .read(
                                                          passwordNotifierProvider
                                                              .notifier)
                                                      .deleteProduct(password);

                                                  context.pop();

                                                  final snackBar = SnackBar(
                                                    content: Text(
                                                      'Password deleted successfully',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Subtitle"),
                                                    ),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                },
                                                child: Text("Yes"),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  onTap: () {
                                    context.push(
                                      '/${Routes.viewPasswordPage}',
                                      extra:
                                          password, // Pass the selected password object here
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      password.appName.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Title',
                                      ),
                                      // style: Theme.of(context).textTheme.headlineSmall,
                                    ),
                                    leading: Container(
                                        height: 48,
                                        width: 48,
                                        child: CircleAvatar(
                                            backgroundColor:
                                                Color(password.color!),
                                            child: Icon(
                                              IconData(
                                                password
                                                    .icon!, // The stored codePoint value
                                                fontFamily:
                                                    'MaterialIcons', // Ensure this matches the icon set
                                              ),
                                              color: Colors
                                                  .white, // Customize as needed
                                            ))),
                                    subtitle: password.userName != ""
                                        ? Text(
                                            password.userName.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Subtitle',
                                            ),
                                          )
                                        : Text(
                                            "No username specified",
                                            style: TextStyle(
                                              fontFamily: 'Subtitle',
                                            ),
                                          ),
                                  ),
                                );
                              },
                            )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode ? Colors.green : primaryColor,
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () async {
          // context.push('/${Routes.addPasswordScreen}');
          context.push('/addPasswordScreen');
        },
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 9), radix: 16) + 0xFF000000);
  }
}
