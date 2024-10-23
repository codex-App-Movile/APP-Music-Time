import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/AuthenticationProvider.dart';
import 'Views/Home.dart';
import 'Views/login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: login(),
      routes: {
        '/sign-in': (context) => login(),
        '/home': (context) => Home(username: 'YourUsername'),
      },
    );
  }
}