import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/providers/quizes.dart';
import 'package:quiz/screen/desktop/quizDesktop.dart';
import 'package:quiz/screen/finish.dart';
import 'package:quiz/screen/mobile/quizMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz';

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  Quizes _quizes;
  int code = 0;

  @override
  Widget build(BuildContext context) {

    _quizes = Provider.of<Quizes>(context);

    return Scaffold(
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return QuizDesktop();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return QuizMobile();
        }
        return QuizDesktop();
      }),
    );
  }
}
