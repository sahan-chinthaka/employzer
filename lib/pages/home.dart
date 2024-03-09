import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
