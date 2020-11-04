import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeDesktop extends StatefulWidget {
  @override
  _WelcomeDesktopState createState() => _WelcomeDesktopState();
}

class _WelcomeDesktopState extends State<WelcomeDesktop> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Image(
                    image: AssetImage(
                      'assets/images/logobig.png',
                    ),
                    width: width * 0.6,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  AutoSizeText(
                    'Qriosity is an online platform to conduct competitions for SMVITM students.'
                    ' First competition is set of quiz conducted in association with ISTE student chapter of SMVITM. 7 days, 7 themes, 21 quiz. From 13/06/2020 to 19/06/2020.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      letterSpacing: 1,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  AutoSizeText(
                    'Event Starts on 13-06-2020',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      letterSpacing: 2,
                      color: Colors.teal,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AutoSizeText(
                    '6:00 PM - 9:00 PM',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AutoSizeText(
                    'Have any Questions?',
                    style: GoogleFonts.poppins(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  AutoSizeText(
                    'How are winners decided?',
                    style: GoogleFonts.roboto(
                      letterSpacing: 1,
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  AutoSizeText(
                    'Top 10 students at the end of the week with the highest points will be declared as the winner.',
                    style: GoogleFonts.roboto(
                      letterSpacing: 1,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AutoSizeText(
                    'Can I contribute to Qriosity?',
                    style: GoogleFonts.roboto(
                      letterSpacing: 1,
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  AutoSizeText(
                    'Yes, we would love to have people on board. Have any ideas to conduct competitions? Contact us.',
                    style: GoogleFonts.roboto(
                      letterSpacing: 1,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AutoSizeText(
                    'Any trouble with the leader board?',
                    style: GoogleFonts.roboto(
                      letterSpacing: 1,
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  AutoSizeText(
                    'I have attempted the quiz but its showing 0 in leaderboard. '
                    'Please wait for the website to calculate and display your final result before you close it. If you close or minimize the website during quiz, you will be scored 0.',
                    style: GoogleFonts.roboto(
                      letterSpacing: 1,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AutoSizeText(
                    'Having trouble with sign in?',
                    style: GoogleFonts.roboto(
                      letterSpacing: 1,
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  AutoSizeText(
                    'If your classmate is having trouble signing in, '
                        'we have dropped our contact links below. Tell your friend to contact us. We will fix it.',
                    style: GoogleFonts.roboto(
                      letterSpacing: 1,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AutoSizeText(
                    'Team',
                    style: GoogleFonts.poppins(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  AutoSizeText(
                    'X TO INFINITY',
                    style: TextStyle(
                        letterSpacing: 2,
                        color: Colors.teal,
                        fontSize: 28,
                        fontFamily: 'Vampire'),
                  ),
                  AutoSizeText(
                    'To Infinity and Beyond',
                    style: GoogleFonts.poppins(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Contact Us : ',
                        style: GoogleFonts.poppins(
                          letterSpacing: 2,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchURL(
                              'https://www.instagram.com/x_to_infinity/');
                        },
                        child: Image(
                          image: AssetImage('assets/images/instagram.png'),
                          height: height * 0.034,
                          width: height * 0.034,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
