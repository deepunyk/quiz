import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProfileMobile extends StatefulWidget {
  @override
  _UserProfileMobileState createState() => _UserProfileMobileState();
}

class _UserProfileMobileState extends State<UserProfileMobile> {
  String name, usn, password, profilePic;
  final _formKey = GlobalKey<FormState>();
  var _password = '';
  var _cPassword = '';

  Future getSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      usn = prefs.getString('usn');
      password = prefs.getString('password');
      profilePic = prefs.getString('profilepic');
      getProfileStat();
    });
    print(name + usn + password + profilePic);
  }

  Map data;
  List list;

  Future getProfileStat() async {
    http.Response response = await http.post(
        'https://xtoinfinity.tech/quiz/php/getQuizStat.php',
        body: {'usn': usn});
    print(response.body.substring(0, response.body.length - 1));
    if (response.body.toString() == 'no quiz') {
      list = null;
    } else {
      data = json.decode(response.body.substring(0, response.body.length - 1));
      setState(() {
        list = data['stat'];
      });
      print(list.toString());
    }
  }

  stat(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.blueGrey[900],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    list[index]['name'],
                    style: GoogleFonts.poppins(
                        letterSpacing: 1, color: Colors.teal, fontSize: 18),
                  ),
                  AutoSizeText(
                    'Quiz : ' + list[index]['qid'],
                    style: GoogleFonts.poppins(
                        letterSpacing: 1, color: Colors.teal, fontSize: 14),
                  ),
                ],
              ),
              AutoSizeText(
                getPoints(list[index]['points']).toString() + '/10',
                style: GoogleFonts.poppins(
                    letterSpacing: 1, color: Colors.teal, fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.red,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.amber,
            ),
            value: getPoints(list[index]['points']) / 10,
          )
        ],
      ),
    );
  }

  int getPoints(String point) {
    int p;
    switch (point) {
      case '10':
        p = 1;
        break;
      case '20':
        p = 2;
        break;
      case '30':
        p = 3;
        break;
      case '40':
        p = 4;
        break;
      case '50':
        p = 5;
        break;
      case '60':
        p = 6;
        break;
      case '70':
        p = 7;
        break;
      case '80':
        p = 8;
        break;
      case '90':
        p = 9;
        break;
      case '100':
        p = 10;
        break;
      default:
        p = 0;
    }
    return p;
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
    }
    if ((_password != _cPassword) && isValid) {
      print('error');
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return _msgDialog('Password and Confirm password does not match.');
          });
    } else if ((_password == _cPassword) && isValid) {
      Navigator.of(context).pop();
      _updatePassword(_password, usn);
    }
  }

  Future _updatePassword(String password, String usn) async {
    print(password + usn);
    http.Response response = await http.post(
        'https://xtoinfinity.tech/quiz/php/updatePassword.php',
        body: {'usn': usn, 'password': password});
    print(response.body.toString());
    if (response.body.toString() == 'no;') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return _msgDialog('Failed to update the password. Try again.');
          });
    } else if (response.body.toString() == 'success;') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return _msgDialog('Password Changed Successfully');
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return _msgDialog('An error occurred while updating the password.');
          });
    }
  }

  Widget _msgDialog(String msg) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Card(
        child: Container(
          width: width * 0.8,
          height: height * 0.3,
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                msg,
                style: GoogleFonts.poppins(
                  letterSpacing: 1,
                  color: Colors.teal,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: height * 0.06,
                  width: width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                  child: Center(
                    child: AutoSizeText(
                      'OK',
                      style: GoogleFonts.poppins(
                        letterSpacing: 1,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editPassword() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Container(
            width: width * 0.8,
            height: height * 0.6,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          'Change Password',
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            letterSpacing: 2,
                            color: Colors.teal,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.cancel),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Password must be atleast 4 charecters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'New Password'),
                      obscureText: true,
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Password must be atleast 4 charecters long';
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      onSaved: (value) {
                        _cPassword = value;
                      },
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        _trySubmit();
                        //Navigator.of(context).pop();
                      },
                      child: Container(
                        width: width * 0.5,
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                        ),
                        child: Center(
                          child: AutoSizeText(
                            'SUBMIT',
                            style: GoogleFonts.poppins(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSP();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.blueGrey[900],
      child: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          height: height,
          width: width,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width*0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          name.toString(),
                          style: GoogleFonts.poppins(
                              letterSpacing: 2,
                              color: Colors.teal,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          usn.toString(),
                          style: GoogleFonts.poppins(
                            letterSpacing: 1,
                            color: Colors.blueGrey[900],
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return _editPassword();
                              });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.teal,
                              size: height * 0.03,
                            ),
                            SizedBox(
                              width: height * 0.01,
                            ),
                            AutoSizeText(
                              'Password',
                              style: GoogleFonts.poppins(
                                letterSpacing: 1,
                                color: Colors.teal,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      GestureDetector(
                        onTap: _logout,
                        child: Row(
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.teal,
                              size: height * 0.03,
                            ),
                            SizedBox(
                              width: height * 0.01,
                            ),
                            AutoSizeText(
                              'Logout',
                              style: GoogleFonts.poppins(
                                letterSpacing: 1,
                                color: Colors.teal,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: list == null ? 0 : list.length,
                  itemBuilder: (ctx, index) {
                    return stat(index);
                  },
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
