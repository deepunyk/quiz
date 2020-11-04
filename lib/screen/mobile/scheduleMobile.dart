import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ScheduleMobile extends StatefulWidget {
  @override
  _ScheduleMobileState createState() => _ScheduleMobileState();
}

class _ScheduleMobileState extends State<ScheduleMobile> {
  Map data;
  List list;
  bool isLoad = true;

  Future getMasterData() async {
    http.Response response =
        await http.post('https://xtoinfinity.tech/quiz/php/getQuizMaster.php');
    print(response.body.substring(0, response.body.length - 1));
    if (response.body.toString() == 'no quiz') {
      list = null;
    } else {
      data = json.decode(response.body.substring(0, response.body.length - 1));
      setState(() {
        list = data['master'];
        isLoad = false;
      });
      print(list.toString());
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  masterCard(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                list[index]['name'],
                maxLines: 1,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Colors.teal,
                    fontWeight: FontWeight.w600
                ),
              ),
              AutoSizeText(
                "Theme: ${list[index]['theme']}",
                maxLines: 1,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  letterSpacing: 1,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  AutoSizeText(
                    'Creator : ' + list[index]['master'],
                    maxLines: 1,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      letterSpacing: 1,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        _launchURL(list[index]['masterLink']);
                      },
                      child: Image(
                        image: AssetImage('assets/images/instagram.png'),
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width * 0.034,
                        height: MediaQuery.of(context).size.width * 0.034,
                      )),
                ],
              ),
            ],
          ),
          AutoSizeText(
            list[index]['date'],
            maxLines: 1,
            style: GoogleFonts.poppins(
              fontSize: 14,
              letterSpacing: 1,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMasterData();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadWidget() {
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(
              "Please wait, getting data",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
      ),
      child: isLoad
          ? loadWidget()
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: AutoSizeText(
                        'EVENT SCHEDULE',
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                          letterSpacing: 2,
                          color: Colors.teal,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                        height: 30,
                        width: 30,
                        image: AssetImage(
                          'assets/images/schedule.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: list == null ? 0 : list.length,
                    itemBuilder: (ctx, index) {
                      return masterCard(index);
                    },
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                  ),
                ),
              ],
            ),
    );
  }
}
