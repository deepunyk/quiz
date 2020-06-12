import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/aboutDesktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/about';
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveBuilder(builder: (context, sizingInformation) {
      // Check the sizing information here and return your UI
      if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
        return AboutDesktop();
      }
      if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
        return AboutDesktop();
      }
      return AboutDesktop();
    }));
  }
}
