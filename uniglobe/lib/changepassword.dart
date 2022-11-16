import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniglobe/color%20code.dart';

import 'main.dart';

class changepassword extends StatefulWidget {
  const changepassword({Key? key}) : super(key: key);

  @override
  State<changepassword> createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Future<void> changePasswordFunction() async {
    try {
      var url = "${baseUrl}change_password";
      SharedPreferences pref = await SharedPreferences.getInstance();
      var userID = pref.getString('userid');
      var finalurl = Uri.parse(url);
      var body = {
        'confirm_password': newPassword.text,
        'old_password': oldPassword.text,
        'id': userID.toString()
      };
      var res = await http.post(finalurl,
          headers: <String, String>{'x-api-key': token}, body: body);

      var decodeValue = json.decode(res.body);
      if (decodeValue['status']) {
        newPassword.clear();
        oldPassword.clear();
        confirmPassword.clear();
        Fluttertoast.showToast(msg: "Password change successfully");
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Password change failed");
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
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                icon: const Image(
                  image: AssetImage("assets/arrow.png"),
                  // width: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          backgroundColor: whitegrey,
          elevation: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(children: [
                Column(children: [
                  Row(
                    children: [
                      Text(
                        'Change Password',
                        style: TextStyle(
                            color: greenn,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ]),
                Padding(
                    padding: const EdgeInsets.only(right: 20, top: 20),
                    child: Column(children: [
                      Container(
                        height: height_ / 2.80,
                        width: width_ / 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: greenn)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: greenn,
                                          offset: const Offset(
                                            2.0,
                                            2.0,
                                          ),
                                          blurRadius: 2.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ]),
                                  child: TextFormField(
                                    controller: oldPassword,
                                    decoration: InputDecoration(
                                      hintText: 'Old Password',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      contentPadding: EdgeInsets.only(left: 10),
                                      border: InputBorder.none,
                                    ),
                                    // keyboardType: TextInputType.number,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: greenn,
                                          offset: const Offset(
                                            2.0,
                                            2.0,
                                          ),
                                          blurRadius: 2.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ]),
                                  child: TextFormField(
                                    controller: newPassword,
                                    decoration: InputDecoration(
                                      hintText: 'New Password',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      contentPadding: EdgeInsets.only(left: 10),
                                      border: InputBorder.none,
                                    ),
                                    // keyboardType: TextInputType.number,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: greenn,
                                          offset: const Offset(
                                            2.0,
                                            2.0,
                                          ),
                                          blurRadius: 2.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ]),
                                  child: TextFormField(
                                    controller: confirmPassword,
                                    decoration: InputDecoration(
                                      hintText: 'Confirm Password',
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      contentPadding: EdgeInsets.only(left: 10),
                                      border: InputBorder.none,
                                    ),
                                    // keyboardType: TextInputType.number,
                                  )),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: greenn),
                                    onPressed: (() {
                                      if (oldPassword.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Old password is empty");
                                      } else if (newPassword.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "New password is empty");
                                      } else if (confirmPassword.text !=
                                          newPassword.text) {
                                        Fluttertoast.showToast(
                                            msg: "Password mismatch");
                                      } else {
                                        changePasswordFunction();
                                      }
                                    }),
                                    child: Text('SUMBIT'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]))
              ])),
        )));
  }
}
