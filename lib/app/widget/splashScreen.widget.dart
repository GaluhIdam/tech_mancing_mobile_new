import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(4, 99, 128, 1),
        body: Center(
          child: Image.asset("assets/logo.png"),
        ),
      ),
    );
  }
}
