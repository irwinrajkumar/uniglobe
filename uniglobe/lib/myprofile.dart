import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniglobe/color%20code.dart';
import 'package:uniglobe/homepage.dart';
import 'package:uniglobe/main.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'TermsandConditions.dart';
import 'about.dart';
import 'bottomnav.dart';
import 'contactus.dart';
import 'privacypolicy.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class myprofile extends StatefulWidget {
  const myprofile({Key? key}) : super(key: key);

  @override
  State<myprofile> createState() => _myprofileState();
}

class _myprofileState extends State<myprofile> {
  var userName;
  var mobile;
  var mail;
  var profile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFunction();
    user();

    // uploadProfile();
  }

  initFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString('username');
      mobile = pref.getString('mobile');
      mail = pref.getString('mail');
    });
  }

  CroppedFile? _croppedFile;

  File? _image;
  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 100,
    );
    if (image == null) return;
    // final imageTemporary = File(image.path);
    await _cropImage(image.path);
  }

  Future<Null> _cropImage(String? imagespath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagespath.toString(),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    setState(() {
      Get.back();
      _image = File(croppedFile!.path);
      // ImagePickerController.text = croppedFile.path;
      print(_image!.path);
    });
    if (_image != null) {
      uploadProfile(_image!);
    }
  }

  var new_pic = [];

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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => bottomsheet()),
                    (Route<dynamic> route) => false);
              }),
        ),
        backgroundColor: whitegrey,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            Column(children: [
              Row(
                children: [
                  Text(
                    'My Profile',
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
                  height: height_ / 1.40,
                  width: width_ / 1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: greenn)),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                          child: Stack(children: [
                        ClipOval(
                            child: _image != null
                                ? Image.file(_image!,
                                    height: 100, width: 100, fit: BoxFit.cover)
                                : (profile != null &&
                                        profile['profile_image'].toString() !=
                                            "null")
                                    ? Image.network(
                                        profile['profile_image'].toString(),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover)
                                    : Image(
                                        image: AssetImage(
                                        "assets/myprofile.png",
                                      ))),
                        Positioned(
                          right: 1 / 1,
                          child: InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                  // width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                  // padding: EdgeInsets.only(
                                  //     left: 90, top: 12, bottom: 12, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image(
                                        image: AssetImage(
                                          'assets/holiday.png',
                                        ),
                                        width: 200,
                                        height: 200,
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.deepOrangeAccent,
                                            ),
                                            onPressed: () =>
                                                getImage(ImageSource.gallery),
                                            // color: Color.fromARGB(255, 255, 115, 0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.image_outlined,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 15),
                                                Text('Gallery',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(width: 0),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.deepOrangeAccent,
                                            ),
                                            onPressed: () =>
                                                getImage(ImageSource.camera),
                                            // color: Color.fromARGB(255, 255, 115, 0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.camera_alt_outlined,
                                                    color: Colors.white),
                                                SizedBox(width: 15),
                                                Text('Camera',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Image(
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                                // color: Colors.white,
                                image: AssetImage(
                                  "assets/Group 420.png",
                                )),
                          ),
                        ),
                      ])),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            userName ?? '',
                            style: const TextStyle(
                              // width:width_,

                              fontSize: 20,
                              fontFamily: "Exo2",
                              color: greenn,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          Text(
                            mail ?? '',
                            style: const TextStyle(
                              // width:width_,

                              fontSize: 20,
                              fontFamily: "Exo2",
                              color: greenn,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          Text(
                            mobile ?? '',
                            style: const TextStyle(
                              // width:width_,

                              fontSize: 20,
                              fontFamily: "Exo2",
                              color: greenn,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: white,
                              ),
                              child: ListTile(
                                  leading: IconButton(
                                      icon: const Image(
                                          image:
                                              AssetImage("assets/Path 71.png")),
                                      onPressed: () {}),
                                  title: const Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: blackey),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              privacypolicy()),
                                    );
                                  }),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: white,
                              ),
                              child: ListTile(
                                  leading: IconButton(
                                      icon: const Image(
                                          image:
                                              AssetImage("assets/Path 70.png")),
                                      onPressed: () {}),
                                  title: const Text(
                                    'About',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: blackey),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => about()),
                                    );
                                  }),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: white,
                              ),
                              child: ListTile(
                                  leading: IconButton(
                                      icon: const Image(
                                          image:
                                              AssetImage("assets/Path 69.png")),
                                      onPressed: () {}),
                                  title: const Text(
                                    'Terms and Conditions',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: blackey),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              termsandconditions()),
                                    );
                                  }),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: white,
                              ),
                              child: ListTile(
                                  leading: IconButton(
                                      icon: const Image(
                                          image:
                                              AssetImage("assets/Path 68.png")),
                                      onPressed: () {}),
                                  title: const Text(
                                    'Contact us',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: blackey),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => contactus()),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> uploadProfile(File images) async {
    var baseurl = '${baseUrl}uploadProfile';
    final uri = Uri.parse(baseurl);

    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll(
      {
        "Content-type": "application/json; charset=utf-8",
        'X-API-KEY': 'uniglobe@123'
      },
    );

    var pref = await SharedPreferences.getInstance();
    var regId = pref.getString('userid');
    request.fields['customer_id'] = regId.toString();

    print(regId);
    var firstimage;
    //  SharedPreferences pref = await SharedPreferences.getInstance();

    if (_image != null) {
      firstimage =
          await http.MultipartFile.fromPath('profile_image', images.path);
      request.files.add(firstimage);
    }
    //     await http.MultipartFile.fromPath('profile_image', _image!.path);
    // request.files.add(firstimage);

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var data = json.decode(respStr);
    print(data);
  }

  //

  Future<void> user() async {
    var baseurl = '${baseUrl}user';
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userID = pref.getString('userid');
    var url = Uri.parse(baseurl);
    final response = await http.post(url, headers: <String, String>{
      'x-api-key': token,
    }, body: {
      'user_id': '$userID',
    });
    print('$userID');
    var decodeValue = json.decode(response.body);
    setState(() {
      if (decodeValue["data"].length != 0) {
        profile = decodeValue["data"][0];
        print(decodeValue["data"][0]);
      }
    });
  }
}
