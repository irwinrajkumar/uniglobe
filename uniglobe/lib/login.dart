import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniglobe/bottomnav.dart';
// import 'package:uniglobe/bottomnav.dart';
import 'package:uniglobe/color%20code.dart';

import 'package:http/http.dart' as http;
import 'package:uniglobe/homepage.dart';

import 'main.dart';
// import 'package:uniglobe/homepage.dart';
// import 'package:uniglobe/color%20code.dart';
// import 'package:uniglobe/colorcode.dart';
// import 'package:speciality_pharm/bottom_navigation/bottomnav.dart';
// import 'package:speciality_pharm/colors.dart';
// import 'package:speciality_pharm/login/forget_password.dart';
// import 'package:speciality_pharm/bottom_navigation/homepage.dart';
// import 'package:speciality_pharm/login/registerpage.dart';

// import '../main.dart';

// void main() {
//   runApp(MaterialApp(
//     home: Login(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

// var size;
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // GradientValue kdfsf = GradientValue();
  bool _isObscure = true;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  initFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userID = pref.getString('userid');

    if (userID != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => bottomsheet()),
          (Route<dynamic> route) => false);
    }
  }

  Future<void> loginFunction() async {
    try {
      if (await InternetConnectionCheckerPlus().hasConnection) {
        var url = "${baseUrl}login";
        print(url);
        var finalurl = Uri.parse(url);
        var body = {'mobile': userName.text, 'password': password.text};
        var res = await http.post(finalurl,
            headers: <String, String>{'x-api-key': token}, body: body);

        var decodeValue = json.decode(res.body);
        if (decodeValue['status']) {
          print(decodeValue);
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('userid', decodeValue['data']['id'].toString());
          pref.setString('username',
              ('${decodeValue['data']['first_name']} ${decodeValue['data']['last_name']}'));
          pref.setString('mobile', decodeValue['data']['mobile_no'].toString());
          pref.setString('mail', decodeValue['data']['email_id'].toString());
          pref.setString('empid', decodeValue['data']['emp_id'].toString());
          userName.clear();
          password.clear();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => bottomsheet()),
              (Route<dynamic> route) => false);
        } else {
          Fluttertoast.showToast(msg: "Login failed");
        }
      } else {
        Fluttertoast.showToast(msg: "Please turn on network or wifi");
      }
    } catch (ex) {
      print(ex);
      Fluttertoast.showToast(msg: ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaSize(context);
    return Scaffold(
      backgroundColor: whitegrey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: height_ / 3.20,
                    width: width_,
                    child: Image(
                      image: AssetImage(
                        'assets/holiday.png',
                      ),
                    ),
                  ),
                  Container(
                    height: height_ / 3.20,
                    width: width_,
                    child: Image(
                      image: AssetImage(
                        'assets/group.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Padding(padding: EdgeInsets.all(5)),
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 17,
                          color: greenn,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: white,
                        ),
                        child: TextFormField(
                          controller: userName,
                          decoration: InputDecoration(
                            hintText: 'Mobile Number',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey,
                        //     offset: const Offset(
                        //       5.0,
                        //       5.0,
                        //     ),
                        //     blurRadius: 5.0,
                        //     spreadRadius: 1.0,
                        //   ), //BoxShadow
                        //   BoxShadow(
                        //     color: Colors.white,
                        //     offset: const Offset(0.0, 0.0),
                        //     blurRadius: 0.0,
                        //     spreadRadius: 0.0,
                        //   ), //BoxShadow
                        // ],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        // border: Border.all(
                        //   width: 0.5,
                        //   color: Colors.grey,
                        // ),
                      ),
                      child: TextFormField(
                          controller: password,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            contentPadding: EdgeInsets.only(left: 10, top: 13),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: greenn,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            // decoration: InputDecoration(
                            //   hintText: 'Password',
                            //   hintStyle: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.grey),
                            //   contentPadding: EdgeInsets.only(left: 10),
                            //   border: InputBorder.none,
                            // ),
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: greenn),
                        onPressed: (() {
                          if (userName.text.isEmpty) {
                            Fluttertoast.showToast(msg: "Mobile no is empty");
                          } else if (password.text.isEmpty) {
                            Fluttertoast.showToast(msg: "Password is empty");
                          } else {
                            loginFunction();
                          }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => bottomsheet()));
                        }),
                        child: Text('SUMBIT'),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
