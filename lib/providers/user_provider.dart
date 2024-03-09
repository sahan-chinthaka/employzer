import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String name;
  String email;
  String role;

  UserProvider({required this.name, required this.email, required this.role});

  void changeUser({String? name, String? email, String? role}) {
    if (email != null) this.email = email;
    if (name != null) this.name = name;
    if (role != null) this.role = role;
    notifyListeners();
  }
}
