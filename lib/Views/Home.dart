// lib/Views/home.dart
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String username;

  Home({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the back arrow
        title: Text('Home'),
      ),
      body: Center(
        child: Text(
          'Welcome, $username!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}