

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keykeep/riverpod/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/PasswordModel.dart';

// class FormNotifier extends StateNotifier<PasswordFormState> {
//   FormNotifier() : super(const PasswordFormState());
//
//   void updateUserName(String userName) {
//     state = state.copyWith(userName: userName);
//   }
//
//   void updateAppName(String appName) {
//     state = state.copyWith(appName: appName);
//   }
//
//   void updatePassword(String password) {
//     state = state.copyWith(password: password);
//   }
//
//   void updateIcon(String icon) {
//     state = state.copyWith(icon: icon);
//   }
//
//   void updateColor(String color) {
//     state = state.copyWith(color: color);
//   }
//
//     checkPassStrength(String pass) {
//       setState(() {
//         passwordStrength = estimatePasswordStrength(pass);
//         Color passwordStrengthBarColor = Colors.red;
//         if (passwordStrength < 0.4) {
//           passwordStrengthBarColor = Colors.red;
//         } else if (passwordStrength > 0.4 && passwordStrength < 0.7) {
//           passwordStrengthBarColor = Colors.deepOrangeAccent;
//         } else if (passwordStrength < 0.7) {
//           passwordStrengthBarColor = Colors.orange;
//         } else if (passwordStrength > 0.7 || passwordStrength == 0.7) {
//           passwordStrengthBarColor = Colors.green;
//         }
//         setState(() {
//           this.passwordStrengthBarColor = passwordStrengthBarColor;
//         });
//       });
//     }
//
//   void resetForm() {
//     state = const PasswordFormState();  // Resets all fields to their initial values
//   }
//
//
// }


class PasswordNotifier extends StateNotifier<PasswordFormState<List<Password>>> {
  PasswordNotifier() : super(PasswordFormState<List<Password>>(status: DataStatus.idle)) {
    loadProducts();
  }

  List<Password> allPasswordsList = [];
  List<Password> filteredProducts = [];


  // Fetch existing products from SharedPreferences
  Future<void> loadProducts() async {
    try {
      // print('Inside load product');
      // state = PasswordFormState(status: DataStatus.loading);<<<Original>>>
      state = PasswordFormState(status: DataStatus.loading, data: state.data);//Edit
      final prefs = await SharedPreferences.getInstance();
      // await prefs.clear();
      final passwordList = prefs.getString('passwords');
      // print("this is password list : $passwordList");
      if (passwordList != null) {
        final List<dynamic> decodedPasswords = jsonDecode(passwordList);
        // final products = decodedProducts
        //     .map((product) => Product(
        //           name: product['name'],
        //           price: product['price'],
        //           imagePath: product['imagePath'],
        //         ))
        //     .toList();


        final passwords = decodedPasswords.map((password) => Password.fromJson(password)).toList();

        allPasswordsList = passwords;
        // print('All products are ');
        // print("All password list are : $passwords");

        state = PasswordFormState(
            status: DataStatus.success,
            data: passwords);
      } else {
        allPasswordsList = [];
        state = PasswordFormState(
            status: DataStatus.success,
            data: []); // No products found, but still success
      }
    } catch (e) {
      state = PasswordFormState(
          status: DataStatus.error,
          message: 'Failed to load load passwords',
          data: state.data//Edit
      );
    }
  }

  // Filter products based on the query
  void searchProducts(String query) {
    if (query.isEmpty) {
      state = PasswordFormState(status: DataStatus.success, data: allPasswordsList);
      // print(state.data);
    } else {
      // Filter based on query
      // print(query);
      final filtered = allPasswordsList.where((p) {
        return p.appName!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      state = PasswordFormState(status: DataStatus.success, data: filtered);
      // print('filtered data');
      // print(filtered);
    }
  }


  // Add a new product
  Future<void> addPassword(Password password) async {
    // print('Inside notifier, add password function');
    try {
      state = PasswordFormState(status: DataStatus.success, data: state.data);//Edit
      // If state.data is null, initialize it as an empty list
      final currentPasswordsList = state.data ?? [];
      // print("Here is the current password list --------->>>>>>>>>>");
      // print(currentPasswordsList);

      if (!_isDuplicate(currentPasswordsList, password)) {
        final updatedPasswordsList = [...currentPasswordsList, password];

        // Update both allProducts and state data with the new product
        allPasswordsList = updatedPasswordsList;
        state = PasswordFormState(status: DataStatus.success, data: allPasswordsList);

        // print('App name ');
        // print(password.appName);

        _saveProducts(allPasswordsList);
        // _saveProducts(updatedProducts);
      } else {
        state = PasswordFormState(status: DataStatus.idle, data: currentPasswordsList, message: 'Already exists! Try a different title');
      }
    } catch (e) {
      state = PasswordFormState(status: DataStatus.error, data: state.data, message: 'Failed to add password');
    }
  }

  // Delete a product
  void deleteProduct(Password password) {
    // try {
    //   if (state.data != null) {
    //     final updatedProducts =
    //         state.data!.where((p) => p.name != product.name).toList();
    //     state = DataState(status: DataStatus.success, data: updatedProducts);
    //     _saveProducts(updatedProducts);
    //   }
    // } catch (e) {
    //   state = DataState(
    //       status: DataStatus.error, message: 'Failed to delete product');
    // }

    try {
      if (state.data != null) {
        final updatedProducts = allPasswordsList.where((p) => p.id != password.id).toList();

        // Update both allProducts and state
        allPasswordsList = updatedProducts;
        state = PasswordFormState(status: DataStatus.success, data: allPasswordsList, message: "Password deleted successfully");

        _saveProducts(allPasswordsList);
      }
    } catch (e) {
      state = PasswordFormState(
          status: DataStatus.error, message: 'Failed to delete password'
      );
    }

  }

  // Check for duplicates
  bool _isDuplicate(List<Password> paswords, Password password) {
    return paswords.any((p) => p.appName == password.appName);
  }

  // Save products to SharedPreferences
  Future<void> _saveProducts(List<Password> passwords) async {
    // print('Inside notifier save products func');
    final prefs = await SharedPreferences.getInstance();
    // final productList = jsonEncode(products
    //     .map((product) => {
    //           'name': product.name,
    //           'price': product.price,
    //           'image': product.imagePath,
    //         })
    //     .toList());
    final passwordList = jsonEncode(passwords.map((password) => password.toJson()).toList());
    // print('password list is $passwordList');
    // print(productList);
    await prefs.setString('passwords', passwordList);
  }

}
