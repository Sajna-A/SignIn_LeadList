import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_list/SCREENS/list_screen.dart';
// import 'package:login_list/login_screen.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.context) : super(LoginInitial());
  BuildContext context;
  TextEditingController UsernameCtrl = TextEditingController();
  TextEditingController PasswordCtrl = TextEditingController();

  Future<void> Login() async {
    final String Url = "https://crm-beta-api.vozlead.in/api/v2/account/login/";
    final username = UsernameCtrl.text.trim();
    final password = PasswordCtrl.text.trim();
    Map<String, dynamic> body = {
      "username": username,
      "password": password,
    };

    try {
      final response = await http.post(
        Uri.parse(Url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData.containsKey('data') &&
            responseData['data'].containsKey('token')) {
          final String token = responseData['data']['token'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('authToken', token);
          await prefs.setBool('logged', true);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logged in successfully'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ListScreen()));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Error: ${response.statusCode} - ${response.reasonPhrase}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("authToken");
}
