import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMobile extends StatefulWidget {
  @override
  _AboutMobileState createState() => _AboutMobileState();
}

class _AboutMobileState extends State<AboutMobile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  'Qriosity',
                  style: GoogleFonts.poppins(
                    letterSpacing: 2,
                    color: Colors.teal,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                AutoSizeText(
                  'Qriosity is an online platform to conduct competitions for SMVITM students.'
                  ' First competition is set of quiz conducted in association with ISTE student chapter of SMVITM. 7 days, 7 themes, 21 quiz. From 13/06/2020 to 19/06/2020',
                  style: GoogleFonts.roboto(
                    letterSpacing: 1,
                    color: Colors.blueGrey[900],
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.teal,
                  thickness: 2,
                ),
                SizedBox(
                  height: 20,
                ),
                AutoSizeText(
                  'Q/A',
                  style: GoogleFonts.poppins(
                    letterSpacing: 2,
                    color: Colors.teal,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                AutoSizeText(
                  'How are winners decided?',
                  style: GoogleFonts.roboto(
                    letterSpacing: 1,
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                AutoSizeText(
                  'Top 10 students at the end of the week with the highest points will be declared as the winner.',
                  style: GoogleFonts.roboto(
                    letterSpacing: 1,
                    color: Colors.blueGrey[900],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                AutoSizeText(
                  'Can I contribute to Qriosity?',
                  style: GoogleFonts.roboto(
                    letterSpacing: 1,
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                AutoSizeText(
                  'Yes, we would love to have people on board. Have any ideas to conduct competitions? Contact us.',
                  style: GoogleFonts.roboto(
                    letterSpacing: 1,
                    color: Colors.blueGrey[900],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                AutoSizeText(
                  'Any trouble with the leader board?',
                  style: GoogleFonts.roboto(
                    letterSpacing: 1,
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                AutoSizeText(
                  'I have attempted the quiz but its showing 0 in leaderboard. '
                  'Please wait for the website to calculate and display your final result before you close it. If you close or minimize the website during quiz, you will be scored 0.',
                  style: GoogleFonts.roboto(
                    letterSpacing: 1,
                    color: Colors.blueGrey[900],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                AutoSizeText(
                  'Having trouble with sign in?',
                  style: GoogleFonts.roboto(
                    letterSpacing: 1,
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                AutoSizeText(
                  'If your classmate is having trouble signing in, '
                  'we have dropped our contact links below. Tell your friend to contact us. We will fix it.',
                  style: GoogleFonts.roboto(
                    letterSpacing: 1,
                    color: Colors.blueGrey[900],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.teal,
                  thickness: 2,
                ),
                SizedBox(
                  height: 20,
                ),
                AutoSizeText(
                  'Team',
                  style: GoogleFonts.poppins(
                    letterSpacing: 2,
                    color: Colors.blueGrey[900],
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AutoSizeText(
                  'X TO INFINITY',
                  style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.teal,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Vampire'),
                ),
                AutoSizeText(
                  'To Infinity and Beyond',
                  style: GoogleFonts.poppins(
                    letterSpacing: 2,
                    color: Colors.blueGrey[900],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
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
                        color: Colors.blueGrey[900],
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchURL('https://www.instagram.com/x_to_infinity/');
                      },
                      child: Image(
                        image: AssetImage('assets/images/instagram.png'),
                        height: height * 0.04,
                        width: width * 0.04,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
