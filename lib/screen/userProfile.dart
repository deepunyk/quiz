import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/userProfileDesktop.dart';
import 'package:quiz/screen/mobile/userProfileMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/userProfile';
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return UserProfileDesktop();
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return UserProfileMobile();
          }
          return UserProfileDesktop();
        },
      ),
    );
  }
}
