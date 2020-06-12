import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProfileDesktop extends StatefulWidget {
  @override
  _UserProfileDesktopState createState() => _UserProfileDesktopState();
}

class _UserProfileDesktopState extends State<UserProfileDesktop> {
  String name, usn, password, profilePic;

  Future getSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      usn = prefs.getString('usn');
      password = prefs.getString('password');
      profilePic = prefs.getString('profilepic');
      getProfileStat();
    });
    print(name + usn + password + profilePic);
  }

  Map data;
  List list;

  Future getProfileStat() async {
    http.Response response = await http.post(
        'https://xtoinfinity.tech/quiz/php/getQuizStat.php',
        body: {'usn': usn});
    print(response.body.substring(0, response.body.length - 1));
    if (response.body.toString() == 'no quiz') {
      list = null;
    } else {
      data = json.decode(response.body.substring(0, response.body.length - 1));
      setState(() {
        list = data['stat'];
      });
      print(list.toString());
    }
  }

  stat(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.blueGrey[900],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    list[index]['name'],
                    style: GoogleFonts.poppins(
                        letterSpacing: 1, color: Colors.teal, fontSize: 18),
                  ),
                  AutoSizeText(
                    'Quiz : ' + list[index]['qid'],
                    style: GoogleFonts.poppins(
                        letterSpacing: 1, color: Colors.teal, fontSize: 14),
                  ),
                ],
              ),
              AutoSizeText(
                getPoints(list[index]['points']).toString() + '/10',
                style: GoogleFonts.poppins(
                    letterSpacing: 1, color: Colors.teal, fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.red,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.amber,
            ),
            value: getPoints(list[index]['points']) / 10,
          )
        ],
      ),
    );
  }

  int getPoints(String point) {
    int p;
    switch (point) {
      case '10':
        p = 1;
        break;
      case '20':
        p = 2;
        break;
      case '30':
        p = 3;
        break;
      case '40':
        p = 4;
        break;
      case '50':
        p = 5;
        break;
      case '60':
        p = 6;
        break;
      case '70':
        p = 7;
        break;
      case '80':
        p = 8;
        break;
      case '90':
        p = 9;
        break;
      case '100':
        p = 10;
        break;
    }
    return p;
  }

  @override
  void initState() {
    super.initState();
    getSP();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.blueGrey[900],
      child: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          height: height,
          width: width * 0.5,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profilePic.toString()),
                    radius: 40,
                    backgroundColor: Colors.teal,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        name.toString(),
                        style: GoogleFonts.poppins(
                            letterSpacing: 1,
                            color: Colors.blueGrey[900],
                            fontSize: 18),
                      ),
                      AutoSizeText(
                        usn.toString(),
                        style: GoogleFonts.poppins(
                            letterSpacing: 1,
                            color: Colors.blueGrey[900],
                            fontSize: 14),
                      ),
                      AutoSizeText(
                        'Change Password',
                        style: GoogleFonts.poppins(
                            letterSpacing: 1, color: Colors.teal, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              ListView.builder(
                itemCount: list == null ? 0 : list.length,
                itemBuilder: (ctx, index) {
                  return stat(index);
                },
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
