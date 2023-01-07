import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login.dart';
// import 'package:uniglobe/login.dart';

var baseUrl = "https://uniglobe.teckzy.co.in/restApi/UserApi/";
var baseUrlimage = "https://uniglobe.teckzy.co.in/restApi/upload/profile/";
var baseimageupload = "https://uniglobe.teckzy.co.in/";
var token = "uniglobe@123";

void main() {
  runApp(GetMaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,
  ));
}
