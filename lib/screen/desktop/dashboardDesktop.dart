import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/screen/about.dart';
import 'package:quiz/screen/gameAbout.dart';
import 'package:quiz/screen/leaderboard.dart';
import 'package:quiz/screen/schedule.dart';
import 'package:quiz/screen/selectQuiz.dart';
import 'package:quiz/screen/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardDesktop extends StatefulWidget {
  @override
  _DashboardDesktopState createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop> {
  SharedPreferences prefs;
  String name = "";
  var myGroup = AutoSizeGroup();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/images/logomed.png",
              height: _mediaQuery.height * 0.1,
            ),
            Text(
              "v1.0.1.0",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: _mediaQuery.height * 0.6,
                  width: _mediaQuery.width * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 8,
                        child: Container(
                          height: _mediaQuery.height * 0.25,
                          width: _mediaQuery.width * 0.25,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              hoverColor: Color(0x333BC0B0),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(UserProfileScreen.routeName);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _mediaQuery.width * 0.03,
                                    vertical: _mediaQuery.height * 0.03),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      AntDesign.user,
                                      color: Theme.of(context).accentColor,
                                      size: _mediaQuery.width * 0.05,
                                    ),
                                    AutoSizeText(
                                      "PROFILE",
                                      group: myGroup,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 30,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Theme.of(context).accentColor,
                                              blurRadius: 1,
                                            )
                                          ]),
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 8,
                        child: Container(
                          height: _mediaQuery.height * 0.25,
                          width: _mediaQuery.width * 0.25,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              hoverColor: Color(0x333BC0B0),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AboutScreen.routeName);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _mediaQuery.width * 0.03,
                                    vertical: _mediaQuery.height * 0.03),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      FontAwesome5.question_circle,
                                      color: Theme.of(context).accentColor,
                                      size: _mediaQuery.width * 0.05,
                                    ),
                                    AutoSizeText(
                                      "ABOUT QRIOSITY",
                                      group: myGroup,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 30,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Theme.of(context).accentColor,
                                              blurRadius: 1,
                                            )
                                          ]),
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 8,
                  child: Container(
                    height: _mediaQuery.height * 0.6,
                    width: _mediaQuery.width * 0.25,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        hoverColor: Color(0x333BC0B0),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(GameAboutScreen.routeName);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              AntDesign.play,
                              color: Theme.of(context).accentColor,
                              size: _mediaQuery.width * 0.1,
                            ),
                            Text(
                              "PLAY",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 30,
                                  shadows: [
                                    Shadow(
                                      color: Theme.of(context).accentColor,
                                      blurRadius: 1,
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: _mediaQuery.height * 0.6,
                  width: _mediaQuery.width * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 8,
                        child: Container(
                          height: _mediaQuery.height * 0.25,
                          width: _mediaQuery.width * 0.25,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              hoverColor: Color(0x333BC0B0),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(LeaderBoardScreen.routeName);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _mediaQuery.width * 0.03,
                                    vertical: _mediaQuery.height * 0.03),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      AntDesign.Trophy,
                                      color: Theme.of(context).accentColor,
                                      size: _mediaQuery.width * 0.05,
                                    ),
                                    AutoSizeText(
                                      "LEADERBOARD",
                                      group: myGroup,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 30,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Theme.of(context).accentColor,
                                              blurRadius: 1,
                                            )
                                          ]),
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 8,
                        child: Container(
                          height: _mediaQuery.height * 0.25,
                          width: _mediaQuery.width * 0.25,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              hoverColor: Color(0x333BC0B0),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ScheduleScreen.routeName);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _mediaQuery.width * 0.03,
                                    vertical: _mediaQuery.height * 0.03),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      FontAwesome5.calendar,
                                      color: Theme.of(context).accentColor,
                                      size: _mediaQuery.width * 0.05,
                                    ),
                                    AutoSizeText(
                                      "EVENT SCHEDULE",
                                      group: myGroup,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 30,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Theme.of(context).accentColor,
                                              blurRadius: 1,
                                            )
                                          ]),
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
