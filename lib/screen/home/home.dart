import 'package:fireball/service/auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text("FireBase"),
        backgroundColor: Colors.brown[40],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text("Log out"),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
