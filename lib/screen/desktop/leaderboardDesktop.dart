import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/screen/profile.dart';

class LeaderboardDesktop extends StatefulWidget {
  @override
  _LeaderboardDesktopState createState() => _LeaderboardDesktopState();
}

class _LeaderboardDesktopState extends State<LeaderboardDesktop> {
  Map data;
  List list;
  int stackIndex = 0;
  bool isLoad = true;

  Future getLeaderBoardData() async {
    http.Response response = await http
        .post('https://xtoinfinity.tech/quiz/php/getLeaderboardData.php');
    if (response.body.toString() == 'no quiz;') {
      isLoad = false;
      list = null;
      stackIndex = 1;
      setState(() {

      });
    } else {
      data = json.decode(response.body.substring(0, response.body.length - 1));
      setState(() {
        list = data['points'];
        isLoad = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLeaderBoardData();
  }

  pointsCard(int index) {
    return GestureDetector(
      onTap: () {
        print(index);
        String usn = list[index]['usn'];
        String total = list[index]['total'];
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext ctx) => ProfileScreen(usn, total)));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  list[index]['name'],
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    letterSpacing: 1,
                    color: Colors.blueGrey[900],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      'Rank : ' + (index + 1).toString(),
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        letterSpacing: 1,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    if (index == 0)
                      Icon(
                        Icons.grade,
                        color: Color(0xffFFD700),
                      )
                    else if (index == 1)
                      Icon(
                        Icons.grade,
                        color: Color(0xffC0C0C0),
                      )
                    else if (index == 2)
                        Icon(
                          Icons.grade,
                          color: Color(0xffb08d57),
                        )
                  ],
                ),
              ],
            ),
            AutoSizeText(
              'Points\n' + list[index]['total'],
              maxLines: 2,
              style: GoogleFonts.poppins(
                fontSize: 14,
                letterSpacing: 1,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final _mediaQuery = MediaQuery.of(context).size;


    Widget loadWidget(){
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(margin: EdgeInsets.only(bottom: _mediaQuery.height*0.03),child: CircularProgressIndicator(strokeWidth: 6.0,),width: _mediaQuery.width*0.05,height: _mediaQuery.width*0.05,),
            Text("Please wait, getting data", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 40),),
          ],
        ),
      );
    }

    return Container(
      child: isLoad ? loadWidget():IndexedStack(
        index: stackIndex,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/victory.png'),
                      fit: BoxFit.contain,
                      height: 400,
                      width: 400,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: AutoSizeText(
                            'LEADERBOARD',
                            minFontSize: 24,
                            maxFontSize: 30,
                            maxLines: 1,
                            style: GoogleFonts.poppins(
                              letterSpacing: 2,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        Image(
                          height: height * 0.05,
                          width: width * 0.05,
                          image: AssetImage(
                            'assets/images/podium.png',
                          ),
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: list == null ? 0 : list.length,
                        itemBuilder: (ctx, index) {
                          return pointsCard(index);
                        },
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/nodata.png'),
                height: height * 0.8,
                width: width * 0.6,
                fit: BoxFit.contain,
              ),
              SizedBox(width: double.infinity,height: _mediaQuery.height*0.1,),
              Text("Leaderboard is Empty", style: GoogleFonts.poppins(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),),
            ],
          ),
        ],
      ),
    );
  }
}
