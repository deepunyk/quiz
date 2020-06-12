import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/rulesDesktop.dart';
import 'package:quiz/screen/mobile/rulesMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RuleScreen extends StatefulWidget {

  static const routeName = '/rules';
  @override
  _RuleScreenState createState() => _RuleScreenState();
}

class _RuleScreenState extends State<RuleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return RulesDesktop();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return RulesMobile();
        }
        return RulesDesktop();
      }),
    );
  }
}
