import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/leaderboardDesktop.dart';
import 'package:quiz/screen/mobile/leaderboardMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LeaderBoardScreen extends StatefulWidget {

  static const routeName = '/leaderboard';

  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return LeaderboardDesktop();
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return LeaderboardMobile();
          }
          return LeaderboardDesktop();
        },
      ),
    );
  }
}