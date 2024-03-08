import 'dart:convert';

import 'package:employzer/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class LoginResponse {
  final String status;
  final Map<String, String>? data;

  const LoginResponse({required this.status, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'status': String status,
        'data': Map<String, String> data,
      } =>
        LoginResponse(status: status, data: data),
      _ => throw const FormatException('Failed to load login response: '),
    };
  }
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  void _signIn() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:4017/api/auth/signin'),
      body: {
        'email': emailController.text,
        'password': pwController.text,
      },
    );

    final json = jsonDecode(response.body);

    if (json["status"] == "failed") {
      if (context.mounted) {
        const snackBar = SnackBar(
          content: Text('Email or password is incorrect'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else if ((json["status"] == "success")) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", json["data"]?["token"]);

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Column(
        children: [
          const Text("Sign In here"),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email Address',
            ),
          ),
          TextField(
            controller: pwController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
            ),
          ),
          ElevatedButton(
            onPressed: _signIn,
            child: const Text("Sign In"),
          ),
        ],
      ),
    );
  }
}
