import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../dashboard.dart';
import '../forgotPassword.dart';

class LoginMobile extends StatefulWidget {
  @override
  _LoginDesktopState createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginMobile> {
  String usn = "";
  String password = "";
  String res;
  bool isLoad = false;

  _checkLogin() async {
    setState(() {
      isLoad = true;
    });
    print("${usn.length}, ${password.length}");
    if (usn.length == 10 && password.length > 3) {
      final response =
      await http.post("http://xtoinfinity.tech/quiz/php/login.php", body: {
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
              color: Colors.amber,
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
            color: Colors.amber,
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
      body: Center(
        child:isLoad?CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),) : Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.amber,
                  width: _mediaQuery.width*0.8,
                  padding: EdgeInsets.symmetric(vertical: 30),
                  alignment: Alignment.center,
                  child: Text(
                    "LOGIN",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(hintText: "USN"),
                          cursorColor: Colors.amber,
                          onChanged: (val) {
                            usn = val;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(hintText: "Password"),
                          cursorColor: Colors.amber,
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
                            style: GoogleFonts.poppins(color: Colors.white)),
                        color: Colors.amber,
                        onPressed: () {
                          _checkLogin();
                        },
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ForgotPasswordScreen.routeName);
                        },
                        child: Text("Forgot Password",
                            style: GoogleFonts.poppins(color: Colors.amber)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

