import 'package:employzer/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Employzer"),
      ),
      body: Column(
        children: [
          Text("SCA ${user.email}"),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('About me'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Work experience'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Education'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Skill'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Qualification'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
