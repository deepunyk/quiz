import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz/providers/quizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../quiz.dart';

class FetchMobile extends StatefulWidget {
  @override
  _FetchMobileState createState() => _FetchMobileState();
}

class _FetchMobileState extends State<FetchMobile> {
  Quizes _quizes;
  bool getQuestion = false;
  bool isLoad = true;
  Map quiz;

  _getQuestions()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usn = prefs.getString('usn');
    await _quizes.getData(usn, context, quiz['qid']);
    Navigator.of(context).pushReplacementNamed(QuizScreen.routeName);
    isLoad = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _mediaQuery = MediaQuery.of(context).size;
    _quizes = Provider.of<Quizes>(context);
    quiz = ModalRoute.of(context).settings.arguments;

    if(!getQuestion){
      getQuestion = true;
      _getQuestions();
    }

    Widget loadWidget(){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text("Please wait, getting questions", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),textAlign: TextAlign.center,),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox(width: double.infinity,child: loadWidget()),
    );
  }
}
