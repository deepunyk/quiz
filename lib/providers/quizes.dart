import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz/screen/quiz.dart';
import '../models/quiz.dart';
import 'package:http/http.dart' as http;

class Quizes with ChangeNotifier{
  List<Quiz> _quizes = [
  ];
  int points = 0;
  String qid = "";

  List<Quiz> get quizes{
    return [..._quizes];
  }


  void addPoint(){
    points= points+10;
  }

  void clearArray(){
    _quizes.clear();
    points = 0;
    qid = "";
  }

  int getPoint(){
    return points;
  }

  Future<void> getData(String usn, BuildContext context, String qid)async{
    this.qid = qid;
    final response = await http.post('https://xtoinfinity.tech/quiz/php/getQuizData.php',body: {
      'usn': usn,
      'qid': qid,
    });
    final questionJson = json.decode(response.body.toString().substring(0,response.body.toString().length-1));
    List<Map<String,dynamic>> questionData = questionJson['question'].cast<Map<String,dynamic>>();
    questionData.map((e){
      return _quizes.add(Quiz(
        ansCorrect: e['ansCorrect'] as String,
        ansOne: e['ansOne'] as String,
        ansTwo: e['ansTwo'] as String,
        ansThree: e['ansThree'] as String,
        ansFour: e['ansFour'] as String,
        question: e['question'] as String,
      ));
    }).toList();
    return;
  }

  Future<bool> putPoints(String usn)async{
    final response = await http.post('https://xtoinfinity.tech/quiz/php/updatePoints.php',body: {
      'usn': usn,
      'qid': qid,
      'points': points.toString(),
    });
    if(response.body.toString() == 'yes;'){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> startPutPoints(String usn)async{
    final response = await http.post('https://xtoinfinity.tech/quiz/php/insertQuiz.php',body: {
      'usn': usn,
      'qid': qid,
    });
    if(response.body.toString() == 'yes;'){
      return true;
    }else{
      return false;
    }
  }
}