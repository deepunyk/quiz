import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/providers/quizes.dart';
import 'package:quiz/screen/desktop/dashboardDesktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mobile/dashboardMobile.dart';

class DashboardScreen extends StatefulWidget {

  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  Quizes _quizes;

  @override
  Widget build(BuildContext context) {

    _quizes = Provider.of<Quizes>(context);

    _quizes.clearArray();

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
