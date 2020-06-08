import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordMobile extends StatefulWidget {

  @override
  _ForgotPasswordMobileState createState() => _ForgotPasswordMobileState();
}

class _ForgotPasswordMobileState extends State<ForgotPasswordMobile> {

  String usn = "";
  String res = "";
  String butText = "Go Back";
  bool isLoad = false;

  void sendEmail()async{
    if(usn.length ==10) {
      setState(() {
        isLoad = true;
      });
      final response = await http.post(
          "http://xtoinfinity.tech/quiz/php/sendMail.php", body:
      {
        'usn': usn.toUpperCase(),
      });
      setState(() {
        isLoad = false;
        if (response.body.toString() == 'no;') {
          res =
          'This USN has not been registered yet. Please contact us to register this USN';
        } else {
          res = "Your account password has been sent to " +
              response.body.toString().substring(0, response.body
                  .toString()
                  .length - 1);
        }
      });
    }else{
      AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text("Invalid USN",style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500)),
        content: Text("Enter a valid USN. Example : 4MW19CS120",style: GoogleFonts.poppins(color: Colors.black)),
        actionsPadding: EdgeInsets.only(right: 15, bottom: 15),
        actions: [
          RaisedButton(
            color: Colors.amber,
            onPressed: () {
              Navigator.of(context)
                  .pop();
            },
            child: Text("Okay!",
                style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  Widget sentWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$res",),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            child: Text(butText, style: TextStyle(color: Colors.white)),
            color: Colors.amber,
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final _mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
          child: Container(
            child: res.length != 0 ? sentWidget()
                :Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.amber,
                  width: _mediaQuery.width*0.8,
                  padding: EdgeInsets.symmetric(vertical: 30),
                  alignment: Alignment.center,
                  child: Text(
                    "Recover Password",
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(hintText: "USN"),
                          cursorColor: Colors.amber,
                          onChanged: (val){
                            usn = val;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      RaisedButton(
                        child: Text("Recover password", style: GoogleFonts.poppins(color: Colors.white)),
                        color: Colors.amber,
                        onPressed: () {
                          sendEmail();
                        },
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
