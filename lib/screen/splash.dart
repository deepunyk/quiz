import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/painter/triangleSplash.dart';
import 'package:quiz/screen/dashboard.dart';
import 'package:quiz/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  int loaded = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  _getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('name')) {
      Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;


    Widget _loadWidget() {
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: _mediaQuery.height * 0.03),
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
              ),
              width: _mediaQuery.width * 0.05,
              height: _mediaQuery.width * 0.05,
            ),
            Text(
              "Loading",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _loadWidget()
    );
  }
}
