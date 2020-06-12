import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/screen/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduleDesktop extends StatefulWidget {
  @override
  _ScheduleDesktopState createState() => _ScheduleDesktopState();
}

class _ScheduleDesktopState extends State<ScheduleDesktop> {
  Map data;
  List list;
  int stackIndex = 0;
  bool isLoad = true;

  Future getMasterData() async {
    http.Response response =
        await http.post('https://xtoinfinity.tech/quiz/php/getQuizMaster.php');
    print(response.body.substring(0, response.body.length - 1));
    if (response.body.toString() == 'no quiz') {
      list = null;
      stackIndex = 1;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMasterData();
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
                        width: MediaQuery.of(context).size.width * 0.014,
                        height: MediaQuery.of(context).size.width * 0.014,
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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final _mediaQuery = MediaQuery.of(context).size;

    Widget loadWidget() {
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: _mediaQuery.height * 0.03),
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
              ),
              width: _mediaQuery.width * 0.05,
              height: _mediaQuery.width * 0.05,
            ),
            Text(
              "Please wait, getting data",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 40),
            ),
          ],
        ),
      );
    }

    return Container(
      color: Colors.blueGrey[900],
      child: isLoad
          ? loadWidget()
          : IndexedStack(
              index: stackIndex,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/schedule_bg.png'),
                            fit: BoxFit.contain,
                            height: 400,
                            width: 400,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: AutoSizeText(
                                  'EVENT SCHEDULE',
                                  minFontSize: 24,
                                  maxFontSize: 30,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                    letterSpacing: 2,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                              Image(
                                height: height * 0.05,
                                width: width * 0.05,
                                image: AssetImage(
                                  'assets/images/schedule.png',
                                ),
                                fit: BoxFit.contain,
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
                    ),
                  ],
                ),
                Center(
                  child: Image(
                    image: AssetImage('assets/images/nodata.png'),
                    height: height * 0.8,
                    width: width * 0.6,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
    );
  }
}
