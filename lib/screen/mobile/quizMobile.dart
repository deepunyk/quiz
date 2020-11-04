import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz/painter/triangleSplash.dart';
import 'package:quiz/providers/quizes.dart';

import '../finish.dart';

class QuizMobile extends StatefulWidget {
  @override
  _QuizMobileState createState() => _QuizMobileState();
}

class _QuizMobileState extends State<QuizMobile> with SingleTickerProviderStateMixin{

  int _index = 0;
  Quizes _quizes;
  Timer _timer;
  int _start = 15;
  int initialised = 0;
  double height = 0;
  double width = 0;
  AnimationController _controller;
  Animation<Size> _animation;
  int _countdown= 5;
  int isLoad = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void startCountdown() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
                () {
              if (_countdown < 1) {
                _timer.cancel();
                isLoad = 1;
                startTimer();
              } else {
                _countdown = _countdown - 1;
                setState(() {

                });
              }
            },
          ),
    );
  }

  void startTimer() async{
    await _controller.forward();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
                () {
              if (_start < 1) {
                incrementCounter();
              } else {
                _start = _start - 1;
              }
            },
          ),
    );
  }

  void incrementCounter() {
    _timer.cancel();
    _index++;
    if (_quizes.quizes.length > _index) {
      _start = 15;
      startTimer();
      setState(() {

      });
    }else{
      Navigator.of(context).pushReplacementNamed(FinishScreen.routeName);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery
        .of(context)
        .size;

    _quizes = Provider.of<Quizes>(context);

    Widget countWidget(){
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Quiz starts in", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 35),),
            Container(
              margin: EdgeInsets.only(bottom: _mediaQuery.height * 0.1),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(_mediaQuery.height * 0.03),
              child: Text(_countdown.toString(), style: GoogleFonts.poppins(
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),),
            ),
          ],
        ),
      );
    }

    if (initialised == 0) {
      initialised = 1;
      startCountdown();
      height = _mediaQuery.height;
      width = _mediaQuery.width;
      _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
      _animation = Tween<Size>(begin: Size(width, height), end: Size(0,0)).animate(CurvedAnimation(parent: _controller,curve: Curves.easeIn));
    }

    Widget _getCard(String title) {
      return Card(
        elevation: 8,
        child: Container(
          width: _mediaQuery.width * 0.8,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: Color(0x333BC0B0),
              splashColor: Color(0x4d3BC0B0),
              onTap: (){
                if(title == _quizes.quizes[_index].ansCorrect){
                  _quizes.addPoint();
                }
                  incrementCounter();

              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: _mediaQuery.height * 0.02,
                    horizontal: _mediaQuery.width * 0.05),
                child: Text(
                  title,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: Theme.of(context).accentColor,
                          blurRadius: 1,
                        )
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(_mediaQuery.height * 0.03),
                  child: Text(_start.toString(), style: GoogleFonts.poppins(
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),),
                ),
                SizedBox(height: _mediaQuery.height*0.08,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width*0.05),
                  child: Text(
                    _quizes.quizes[_index].question,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 20,
                        shadows: [
                          Shadow(
                            color: Theme.of(context).accentColor,
                            blurRadius: 1,
                          )
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: _mediaQuery.height*0.05,),
                _getCard(_quizes.quizes[_index].ansOne),
                SizedBox(height: _mediaQuery.height*0.01,),
                _getCard(_quizes.quizes[_index].ansTwo),
                SizedBox(height: _mediaQuery.height*0.01,),
                _getCard(_quizes.quizes[_index].ansThree),
                SizedBox(height: _mediaQuery.height*0.01,),
                _getCard(_quizes.quizes[_index].ansFour),
              ],
            ),
          ),
          AnimatedBuilder(
            builder: ((context, child)=>CustomPaint(
              painter: TrianglePainter(
                  strokeColor: Theme.of(context).accentColor,
                  strokeWidth: 0,
                  paintingStyle: PaintingStyle.fill,
                  mHeight: _mediaQuery.height,
                  mWidth: _mediaQuery.width,
                  direction: 0,
                  tempHeight: _animation.value.height,
                  tempWidth: _animation.value.width),
            )),
            animation: _animation,
          ),
          AnimatedBuilder(
            builder: ((context, child)=>CustomPaint(
              painter: TrianglePainter(
                  strokeColor: Theme.of(context).accentColor,
                  strokeWidth: 0,
                  paintingStyle: PaintingStyle.fill,
                  mHeight: _mediaQuery.height,
                  mWidth: _mediaQuery.width,
                  direction: 1,
                  tempHeight: _animation.value.height,
                  tempWidth: _animation.value.width),
            )),
            animation: _animation,
          ),
          isLoad == 0? countWidget(): Container(),
          isLoad == 0?Align(
            alignment: Alignment.bottomCenter,
            child: Container(margin: EdgeInsets.only(bottom: _mediaQuery.height*0.2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Developed By",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700, color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    "X to INFINITY",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'Vampire', fontSize: 18),
                  ),
                ],
              ),
            ),
          ):Container(),
        ],
      ),
    );
  }
}
