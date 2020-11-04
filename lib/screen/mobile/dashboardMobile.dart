import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/screen/about.dart';
import 'package:quiz/screen/game.dart';
import 'package:quiz/screen/schedule.dart';
import 'package:quiz/screen/userProfile.dart';

import '../leaderboard.dart';
import '../selectQuiz.dart';

class DashboardMobile extends StatefulWidget {
  @override
  _DashboardMobileState createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  var myGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;

    Widget _getCard(String title, IconData icon, Function func) {
      return Card(
        margin: EdgeInsets.zero,
        elevation: 8,
        child: Container(
          width: _mediaQuery.width * 0.8,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: Color(0x333BC0B0),
              splashColor: Color(0x4d3BC0B0),
              onTap: func,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: _mediaQuery.height * 0.02,
                    horizontal: _mediaQuery.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 25,
                          shadows: [
                            Shadow(
                              color: Theme.of(context).accentColor,
                              blurRadius: 1,
                            )
                          ]),
                    ),
                    Icon(
                      icon,
                      color: Theme.of(context).accentColor,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget _getMiniCard(String title, IconData icon, Function func) {
      return Card(
        margin: EdgeInsets.zero,
        elevation: 8,
        child: Container(
          width: _mediaQuery.width * 0.37,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: Color(0x333BC0B0),
              splashColor: Color(0x4d3BC0B0),
              onTap: func,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: _mediaQuery.height * 0.02,
                    horizontal: _mediaQuery.width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        title,
                        group: myGroup,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 13,
                            shadows: [
                              Shadow(
                                color: Theme.of(context).accentColor,
                                blurRadius: 1,
                              )
                            ]),
                        maxLines: title == "LEADERBOARD"?1:2,
                      ),
                    ),
                    Icon(
                      icon,
                      color: Theme.of(context).accentColor,
                      size: _mediaQuery.width * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logomed.png",
              height: _mediaQuery.height * 0.1,
            ),
            Text("v1.0.1.0", style: GoogleFonts.poppins(color: Colors.white),),
            SizedBox(
              height: _mediaQuery.height * 0.1,
            ),
            _getCard("PLAY", AntDesign.play, () {
              Navigator.of(context).pushNamed(GameScreen.routeName);
            }),
            SizedBox(
              height: _mediaQuery.height * 0.05,
            ),
            Container(
              width: _mediaQuery.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getMiniCard("LEADERBOARD", AntDesign.Trophy, () {
                    Navigator.of(context)
                        .pushNamed(LeaderBoardScreen.routeName);
                  }),
                  _getMiniCard("PROFILE", AntDesign.user, () {
                    Navigator.of(context)
                        .pushNamed(UserProfileScreen.routeName);
                  }),
                ],
              ),
            ),
            SizedBox(
              height: _mediaQuery.height * 0.05,
            ),
            Container(
              width: _mediaQuery.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getMiniCard("EVENT\nSCHEDULE", AntDesign.calendar, () {
                    Navigator.of(context).pushNamed(ScheduleScreen.routeName);
                  }),
                  _getMiniCard("ABOUT\nQRIOSITY", AntDesign.questioncircle, () {
                    Navigator.of(context).pushNamed(AboutScreen.routeName);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
