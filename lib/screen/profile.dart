import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/profileDesktop.dart';
import 'package:quiz/screen/mobile/profileMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileScreen extends StatefulWidget {

  ProfileScreen(this.usn, this.total);
  final String usn, total;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
            return ProfileDesktop(widget.usn, widget.total);
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return ProfileMobile(widget.usn, widget.total);
          }
          return ProfileDesktop(widget.usn, widget.total);
        },
      ),
    );
  }
}
