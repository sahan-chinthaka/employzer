import 'dart:convert';

import 'package:employzer/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  void _signIn() async {
    final url = dotenv.env['BACK_END'];
    final response = await http.post(
      Uri.parse('$url/api/auth/signin'),
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
          MaterialPageRoute(builder: (context) => const Loading()),
          (Route<dynamic> route) => false,
        );
        return;
      }
    }
    if (context.mounted) {
      const snackBar = SnackBar(
        content: Text('Unknown error'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
