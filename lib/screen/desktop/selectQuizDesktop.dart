import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/screen/fetch.dart';
import 'package:quiz/screen/rules.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard.dart';

class SelectQuizDesktop extends StatefulWidget {
  @override
  _SelectQuizDesktopState createState() => _SelectQuizDesktopState();
}

class _SelectQuizDesktopState extends State<SelectQuizDesktop> {
  var myGroup = AutoSizeGroup();
  bool isLoad = true;

  List<Map> _quizList = [];

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http
        .post('https://xtoinfinity.tech/quiz/php/getQuizes.php', body: {
      'usn': prefs.getString('usn'),
    });
    print(response.body.toString());
    final quizJson = json.decode(response.body
        .toString()
        .substring(0, response.body.toString().length - 1));
    List<Map<String, dynamic>> quizData =
        quizJson['quiz'].cast<Map<String, dynamic>>();
    quizData.map((e) {
      return _quizList.add(
        {
          'name': e['name'].toString(),
          'qid' : e['qid'].toString(),
          'points': e['points'],
          'master': e['master'].toString(),
          'masterLink' : e['masterLink'].toString(),
        },
      );
    }).toList();
    setState(() {
      isLoad = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {

    final _mediaQuery = MediaQuery.of(context).size;

    Widget _getCard(Map element, Function func, bool isComplete) {
      return Card(
        margin: EdgeInsets.zero,
        elevation: 8,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Color(0x4d3BC0B0),
            onTap: () {
              if(!isComplete) {
                Navigator.of(context).pushReplacementNamed(
                    RuleScreen.routeName, arguments: element);
              }else{
                AlertDialog alert = AlertDialog(
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  title: Text("You have already completed this quiz",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontWeight: FontWeight.w500)),
                  content: Text("You can attempt this only once.",
                      style: GoogleFonts.poppins(color: Colors.black)),
                  actionsPadding: EdgeInsets.only(right: 15, bottom: 15),
                  actions: [
                    RaisedButton(
                      color: Theme.of(context).accentColor,
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
              }
            },
            child: Container(
              width: _mediaQuery.width * .25,
              padding: EdgeInsets.symmetric(
                  horizontal: _mediaQuery.width * 0.02,
                  vertical: _mediaQuery.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    element['name'],
                    group: myGroup,
                    maxLines: 1,
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      isComplete ? "Completed" : "Yet to Complete",
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget loadWidget(){
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(margin: EdgeInsets.only(bottom: _mediaQuery.height*0.03),child: CircularProgressIndicator(strokeWidth: 6.0,),width: _mediaQuery.width*0.05,height: _mediaQuery.width*0.05,),
            Text("Please wait, getting questions", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 40),),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: isLoad ? loadWidget():Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: _mediaQuery.width * 0.9,
                margin: EdgeInsets.only(top: _mediaQuery.height * 0.05),
                alignment: Alignment.centerLeft,
                child: Hero(tag: 'selectLogo',child: Image.asset("assets/images/logomed.png", height: _mediaQuery.height*0.08,)),
              ),
              Container(
                  margin: EdgeInsets.only(top: _mediaQuery.height * 0.05),
                  child: RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: "Today's Theme : ",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              )),
                          TextSpan(
                              text: "Comics & Anime",
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              )),
                        ]),
                  )),
              Container(
                width: _mediaQuery.width * 0.9,
                margin: EdgeInsets.only(top: _mediaQuery.height * 0.05),
                child: Text(
                  "Select topic",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 25),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: _mediaQuery.height * 0.05),
                width: _mediaQuery.width * 0.9,
                child: Row(
                  children: [
                    _getCard(_quizList[0], () {}, _quizList[0]['points'] == 'no' ? false:true),
                    /*_getCard(_quizList[1], () {}, _quizList[1]['points'] == 'no' ? false:true),
                    _getCard(_quizList[2], () {}, _quizList[2]['points'] == 'no' ? false:true),*/
                  ],
                ),
              ),
              SizedBox(
                height: _mediaQuery.height * 0.1,
              ),
              RaisedButton(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "BACK",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
                color: Theme.of(context).accentColor,
              )
            ],
          ),
        ));
  }
}
