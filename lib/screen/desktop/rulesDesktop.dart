import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/screen/dashboard.dart';
import 'package:quiz/screen/fetch.dart';

class RulesDesktop extends StatefulWidget {

  @override
  _RulesDesktopState createState() => _RulesDesktopState();
}

class _RulesDesktopState extends State<RulesDesktop> {
  Map quiz;

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;

    quiz = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              quiz['name'],
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 35),
            ),
            SizedBox(
              height: _mediaQuery.height * 0.02,
            ),
            Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: _mediaQuery.height * 0.02,
                      horizontal: _mediaQuery.width * 0.05),
                  width: _mediaQuery.width * 0.8,
                  child: Column(
                    children: [
                      Text(
                        "Rules and Regulations",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: _mediaQuery.height * 0.01,
                      ),
                      RichText(
                        text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: "• ",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30,
                                      color: Theme.of(context).accentColor)),
                              TextSpan(
                                  text:
                                      "You can try to break this website now, since it is in beta phase.\n",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.black)),
                              TextSpan(
                                  text: "• ",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30,
                                      color: Theme.of(context).accentColor)),
                              TextSpan(
                                  text:
                                      "If you do, don't forget to tell us how you did it.",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.black)),
                            ]),
                      ),
                      SizedBox(
                        height: _mediaQuery.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            child: Text(
                              "BACK",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            width: _mediaQuery.width * 0.03,
                          ),
                          RaisedButton(
                            child: Text(
                              "LETS GO!",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(FetchScreen.routeName, arguments: quiz);
                            },
                            color: Theme.of(context).accentColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
