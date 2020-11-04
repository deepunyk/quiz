import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/providers/quizes.dart';
import 'package:quiz/screen/about.dart';
import 'package:quiz/screen/dashboard.dart';
import 'package:quiz/screen/fetch.dart';
import 'package:quiz/screen/finish.dart';
import 'package:quiz/screen/forgotPassword.dart';
import 'package:quiz/screen/game.dart';
import 'package:quiz/screen/gameAbout.dart';
import 'package:quiz/screen/leaderboard.dart';
import 'package:quiz/screen/login.dart';
import 'package:quiz/screen/quiz.dart';
import 'package:quiz/screen/rules.dart';
import 'package:quiz/screen/schedule.dart';
import 'package:quiz/screen/selectQuiz.dart';
import 'package:quiz/screen/splash.dart';
import 'package:quiz/screen/userProfile.dart';
import 'package:quiz/screen/welcomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Quizes(),
        ),
      ],
      child: MaterialApp(
        title: 'Qriosity',
        theme: ThemeData(
          primaryColor: Color(0xff273238),
          accentColor: Color(0xff3BC0B0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        routes: {
          DashboardScreen.routeName: (ctx) => DashboardScreen(),
          ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
          QuizScreen.routeName: (ctx) => QuizScreen(),
          FetchScreen.routeName: (ctx) => FetchScreen(),
          FinishScreen.routeName: (ctx) => FinishScreen(),
          SplashScreen.routeName: (ctx) => SplashScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          RuleScreen.routeName: (ctx) => RuleScreen(),
          SelectQuiz.routeName: (ctx) => SelectQuiz(),
          LeaderBoardScreen.routeName: (ctx) => LeaderBoardScreen(),
          UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
          AboutScreen.routeName: (ctx) => AboutScreen(),
          ScheduleScreen.routeName: (ctx) => ScheduleScreen(),
          WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
          GameAboutScreen.routeName: (ctx) => GameAboutScreen(),
          GameScreen.routeName: (ctx) => GameScreen(),
        },
      ),
    );
  }
}
