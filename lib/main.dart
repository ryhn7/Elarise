import 'package:elarise/feature_assistant/presentation/assistant_chatroom/assistant_chatroom_screen.dart';
import 'package:elarise/feature_auth/presentation/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elarise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        useMaterial3: true,
      ),
      home: const Login()
    );
  }
}

