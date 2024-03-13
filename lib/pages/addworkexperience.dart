import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addwork extends StatefulWidget {
  const addwork({super.key});

  @override
  State<addwork> createState() => _addworkState();
}

class _addworkState extends State<addwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add work experience'),
      ),

    );
  }
}
