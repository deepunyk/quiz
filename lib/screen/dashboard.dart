import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/dashboardDesktop.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mobile/dashboardMobile.dart';

class DashboardScreen extends StatefulWidget {

  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              // Check the sizing information here and return your UI
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.desktop) {
                return DashboardDesktop();
              }
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.mobile) {
                return DashboardMobile();
              }
              return DashboardDesktop();
            }
        )
    );
  }
}
