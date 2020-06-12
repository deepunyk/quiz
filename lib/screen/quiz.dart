import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/quizDesktop.dart';
import 'package:quiz/screen/mobile/quizMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz';

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
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
