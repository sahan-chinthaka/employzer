import 'dart:convert';

import 'package:employzer/globals.dart' as globals;
import 'package:employzer/pages/home.dart';
import 'package:employzer/pages/signin.dart';
import 'package:employzer/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
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
    final uid = prefs.get("uid");
    await globals.env;
    final url = dotenv.env['BACK_END'];

    if (token != null && uid != null) {
      final resp = await http.get(
        Uri.parse("$url/api/users/$uid"),
        headers: {
          "x-access-token": token.toString(),
        },
      );
      final json = jsonDecode(resp.body);
      if (json["status"] == "success") {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => UserProvider(
                  email: json["data"]?["email"],
                  name: json["data"]?["email"],
                  role: json["data"]?["role"],
                ),
                child: const Home(),
              ),
            ),
            (Route<dynamic> route) => false,
          );
        }
        return;
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
