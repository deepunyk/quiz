import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/forgotPasswordDesktop.dart';
import 'package:quiz/screen/mobile/forgotPasswordMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ForgotPasswordScreen extends StatefulWidget {

  static const routeName = '/forgotPassword';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.desktop) {
                return ForgotPasswordDesktop();
              }
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.mobile) {
                return ForgotPasswordMobile();
              }
              return ForgotPasswordDesktop();
            }
        )
    );
  }
}
