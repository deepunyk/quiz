import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/scheduleDesktop.dart';
import 'package:quiz/screen/mobile/scheduleMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule';
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return ScheduleDesktop();
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return ScheduleMobile();
          }
          return ScheduleDesktop();
        },
      ),
    );
  }
}
