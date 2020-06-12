import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/selectQuizDesktop.dart';
import 'package:quiz/screen/mobile/selectQuizMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SelectQuiz extends StatefulWidget {

  static const routeName = '/selectQuiz';

  @override
  _SelectQuizState createState() => _SelectQuizState();
}

class _SelectQuizState extends State<SelectQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return SelectQuizDesktop();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return SelectQuizMobile();
        }
        return SelectQuizDesktop();
      }),
    );
  }
}
