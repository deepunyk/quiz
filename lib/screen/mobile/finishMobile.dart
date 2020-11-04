import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz/providers/quizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard.dart';

class FinishMobile extends StatefulWidget {
  @override
  _FinishMobileState createState() => _FinishMobileState();
}

class _FinishMobileState extends State<FinishMobile> {
  Quizes _quizes;
  bool isLoad = true;
  bool _putPoint = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _quizes.clearArray();
  }

  _putPoints()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usn = prefs.getString('usn');
    await _quizes.putPoints(usn);
    setState(() {
      isLoad = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    _quizes = Provider.of<Quizes>(context);
    final _mediaQuery = MediaQuery
        .of(context)
        .size;

    if(!_putPoint){
      _putPoint = true;
      _putPoints();
    }

    Widget loadWidget(){
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(margin: EdgeInsets.only(bottom: _mediaQuery.height*0.03),child: CircularProgressIndicator(strokeWidth: 4.0,),width: _mediaQuery.width*0.05,height: _mediaQuery.width*0.05,),
            Text("Please wait, calculating points", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
          ],
        ),
      );
    }


    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: isLoad == true ? loadWidget():Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: _mediaQuery.width*0.8,
              child: Text("QRIOSITY", textAlign: TextAlign.left,
                style: GoogleFonts.poppins(color: Theme
                    .of(context)
                    .accentColor, fontSize: 25,fontWeight: FontWeight.w700),),
            ),
            Card(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 8,
              shadowColor: Theme.of(context).accentColor,
              child: Container(
                  width: _mediaQuery.width * 0.8,
                  padding: EdgeInsets.symmetric(
                      vertical: _mediaQuery.height * 0.05),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Congrats!',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black),),
                      Text('${_quizes.getPoint()} Points',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Theme
                                .of(context)
                                .accentColor),),
                      Text("Quiz completed successfully.",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),),
                      SizedBox(height: _mediaQuery.height*0.01,),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: DefaultTextStyle
                              .of(context)
                              .style,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                              "You have attemped ${_quizes.quizes.length} questions and\n",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text:
                              _quizes.getPoint() == 0 ?"from that 0 answers are correct": "from that ${(_quizes.getPoint())/10} answers are correct",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ),
            ),
            Container(
              width: _mediaQuery.width*0.8,
              child: RaisedButton(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(DashboardScreen.routeName, (route) => false);
                },
                child: Text(
                  "BACK",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
                color: Theme
                    .of(context)
                    .accentColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
