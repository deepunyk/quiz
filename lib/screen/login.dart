import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/screen/desktop/loginDesktop.dart';
import 'package:quiz/screen/mobile/loginMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              // Check the sizing information here and return your UI
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.desktop) {
                return LoginDesktop();
              }
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.mobile) {
                return LoginMobile();
              }
              return LoginDesktop();
            }
        )
    );
  }
}
