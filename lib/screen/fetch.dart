import 'package:flutter/material.dart';
import 'package:quiz/screen/desktop/fetchDesktop.dart';
import 'package:quiz/screen/mobile/fetchMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FetchScreen extends StatefulWidget {

  static const routeName = '/fetch';

  @override
  _FetchScreenState createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.desktop) {
                return FetchDesktop();
              }
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.mobile) {
                return FetchMobile();
              }
              return FetchDesktop();
            }
        )
    );
  }
}
