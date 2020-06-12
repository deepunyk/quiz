import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/finishDesktop.dart';
import 'package:quiz/screen/mobile/finishMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FinishScreen extends StatefulWidget {

  static const routeName = '/finish';

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.desktop) {
                return FinishDesktop();
              }
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.mobile) {
                return FinishMobile();
              }
              return FinishDesktop();
            }
        )
    );
  }
}
