import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pwar_pwar_gyi_app/global_variables.dart';
import 'package:pwar_pwar_gyi_app/model/user.dart';
import 'package:pwar_pwar_gyi_app/provider/user_provider.dart';
import 'package:pwar_pwar_gyi_app/services/manage_http_response.dart';
import 'package:pwar_pwar_gyi_app/view/screens/authentication/signin_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future<void> signUpUsers(
      {required context,
      required String fullName,
      required String email,
      required String role,
      required String password}) async {
    try {

      User user = User(
          id: "",
          fullName: fullName,
          email: email,
          role: role,
          password: password,
          token: '');
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          // Set the header for the request
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8',
          });

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SigninScreen()));
            showSnackBar(context, 'Account has been created.');
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signInUsers(
      {required BuildContext context,
      required email,
      required password,
      required WidgetRef ref}) async {
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8'
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () async {
            // Save authentication token
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            String token = jsonDecode(response.body)['token'];
            preferences.setString('auth_token', token);


            //Save user data after converting json to dart object
            final userJson = jsonEncode(jsonDecode(response.body)['user']);
            ref.read(userProvider.notifier).setUser(userJson);
            await preferences.setString('user', userJson);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
                (route) => false);
            showSnackBar(context, "Successfully login");
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // SignOut
  Future<void> signOutUser(
      {required BuildContext context, required WidgetRef ref}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      // clear the token and user data from shared preference
      await preferences.remove('auth_token');
      await preferences.remove('user');

      // clear the user state
      ref.read(userProvider.notifier).signOut();

      // navigate the user back to the login screen

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SigninScreen()),
          (route) => false);
      showSnackBar(context, "Successfully Sign Out");
    } catch (e) {
      showSnackBar(context, "error in signing out. The error is $e");
    }
  }
}
