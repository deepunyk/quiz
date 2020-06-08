import 'package:flutter/material.dart';
import 'package:quiz/screen/dashboard.dart';
import 'package:quiz/screen/forgotPassword.dart';
import 'package:quiz/screen/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzie!',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      routes: {
        DashboardScreen.routeName:(ctx)=>DashboardScreen(),
        ForgotPasswordScreen.routeName:(ctx)=>ForgotPasswordScreen(),
      },
    );
  }
}
