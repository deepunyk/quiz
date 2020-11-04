import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ProfileDesktop extends StatefulWidget {
  ProfileDesktop(this.usn, this.total);

  final String usn, total;

  @override
  _ProfileDesktopState createState() => _ProfileDesktopState();
}

class _ProfileDesktopState extends State<ProfileDesktop> {
  Map data;
  List list;
  String user = 'User';

  Future getProfileStat() async {
    http.Response response = await http.post(
        'https://xtoinfinity.tech/quiz/php/getQuizStat.php',
        body: {'usn': widget.usn});
    print(response.body.substring(0, response.body.length - 1));
    if (response.body.toString() == 'no quiz') {
      list = null;
    } else {
      data = json.decode(response.body.substring(0, response.body.length - 1));
      setState(() {
        list = data['stat'];
        user = list[0]['user'];
      });
      print(list.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.usn);
    getProfileStat();
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        user,
                        style: GoogleFonts.poppins(
                            letterSpacing: 1,
                            color: Colors.blueGrey[900],
                            fontSize: 18),
                      ),
                      AutoSizeText(
                        widget.usn,
                        style: GoogleFonts.poppins(
                            letterSpacing: 1,
                            color: Colors.blueGrey[900],
                            fontSize: 14),
                      ),
                      AutoSizeText(
                        'Points : ' + widget.total,
                        style: GoogleFonts.poppins(
                            letterSpacing: 1,
                            color: Colors.blueGrey[900],
                            fontSize: 16),
                      ),
                    ],
                  ),
                  Image(
                    image: AssetImage('images/graph.png'),
                    fit: BoxFit.contain,
                    width: width * 0.08,
                    height: height * 0.08,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: list == null ? 0 : list.length,
                  itemBuilder: (ctx, index) {
                    return stat(index);
                  },
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
