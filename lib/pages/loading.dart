import 'dart:convert';

import 'package:employzer/pages/home.dart';
import 'package:employzer/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get("token");

    if (token != null) {
      final resp = await http.get(
        Uri.parse("http://127.0.0.1:4017/api/auth/"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final json = jsonDecode(resp.body);
      if (json["status"] == "success") {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (Route<dynamic> route) => false,
          );
          return;
        }
      }
    }

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Loading..."),
    );
  }
}
