import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {

  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("yolo"),
    );
  }
}
