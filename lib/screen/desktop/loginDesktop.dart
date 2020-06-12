import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/screen/about.dart';
import 'package:quiz/screen/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../forgotPassword.dart';

class LoginDesktop extends StatefulWidget {
  @override
  _LoginDesktopState createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
  String usn = "";
  String password = "";
  String res;
  bool isLoad = false;

  _checkLogin() async {
    if (usn.length == 10 && password.length > 3) {
      setState(() {
        isLoad = true;
      });
      http.Response response =
          await http.post("https://xtoinfinity.tech/quiz/php/login.php", body: {
        'usn': usn.toUpperCase(),
        'password': password,
      });
      setState(() {
        isLoad = false;
      });
      if (response.body.toString() == 'no;') {
        AlertDialog alert = AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text("Invalid login credentials",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w500)),
          content: Text("Click on forgot password to recover your password",
              style: GoogleFonts.poppins(color: Colors.black)),
          actionsPadding: EdgeInsets.only(right: 15, bottom: 15),
          actions: [
            RaisedButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Okay!",
                  style: GoogleFonts.poppins(color: Colors.white)),
            ),
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        final userJson = json.decode(response.body
            .toString()
            .substring(0, response.body.toString().length - 1));
        final userData = userJson['user'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('name', userData[0]['name'].toString());
        prefs.setString('usn', userData[0]['usn'].toString());
        prefs.setString('sem', userData[0]['sem'].toString());
        prefs.setString('section', userData[0]['section'].toString());
        prefs.setString('email', userData[0]['email'].toString());
        prefs.setString('password', userData[0]['password'].toString());
        prefs.setString('branchId', userData[0]['branchId'].toString());
        prefs.setString('profilepic', userData[0]['profilepic'].toString());
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      }
    } else {
      AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text("Invalid login credentials",
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w500)),
        content: Text("Please recheck your USN and password",
            style: GoogleFonts.poppins(color: Colors.black)),
        actionsPadding: EdgeInsets.only(right: 15, bottom: 15),
        actions: [
          RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:
                Text("Okay!", style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: isLoad
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/logomed.png",
                    height: _mediaQuery.height * 0.1,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 8,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            color: Theme.of(context).accentColor,
                            width: _mediaQuery.width * 0.5,
                            padding: EdgeInsets.symmetric(
                                vertical: 30, horizontal: 10),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "LOGIN",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.help,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(AboutScreen.routeName);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    decoration:
                                        InputDecoration(hintText: "USN"),
                                    cursorColor: Theme.of(context).accentColor,
                                    onChanged: (val) {
                                      usn = val;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    obscureText: true,
                                    decoration:
                                        InputDecoration(hintText: "Password"),
                                    cursorColor: Theme.of(context).accentColor,
                                    onChanged: (val) {
                                      password = val;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                RaisedButton(
                                  child: Text("SUBMIT",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white)),
                                  color: Theme.of(context).accentColor,
                                  onPressed: () {
                                    _checkLogin();
                                  },
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "* ",
                                        style: GoogleFonts.poppins(
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                      TextSpan(
                                        text:
                                            "Login credentials are same as that of SMVITM app",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        ForgotPasswordScreen.routeName);
                                  },
                                  child: Text(
                                    "Forgot Password",
                                    style: GoogleFonts.poppins(
                                        color: Theme.of(context).accentColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
