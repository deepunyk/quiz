import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/welcomeDesktop.dart';
import 'package:quiz/screen/mobile/welcomeMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return WelcomeDesktop();
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return WelcomeMobile();
          }
          return WelcomeDesktop();
        },
      ),
    );
  }
}
