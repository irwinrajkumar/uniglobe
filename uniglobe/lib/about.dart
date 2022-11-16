import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uniglobe/color%20code.dart';
import 'package:uniglobe/homepage.dart';
import 'package:uniglobe/main.dart';
import 'package:http/http.dart' as http;

class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  void initState() {
    super.initState();
    aboutdata();
  }

  var boutdata;
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
            child:
             Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(children: [
            Column(children: [
         if(boutdata!=null)     Row(
                children: [
                  Text(
                    boutdata['title'].toString(),
                    style: TextStyle(
                        color: greenn,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ]),
            if(boutdata!=null)
            Padding(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: Column(children: [
                  Container(
                      height: height_ / 1.60,
                      width: width_ / 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: greenn)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              boutdata['description'].toString(),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ))
                ]))
          ]),
        )));
  }

  Future<void> aboutdata() async {
    var baseurl = '${baseUrl}cms';

    var url = Uri.parse(baseurl);
    final response = await http.post(url, headers: <String, String>{
      'x-api-key': token,
    }, body: {
      'page': 'about',
    });

    var decodeValue = json.decode(response.body);
    setState(() {
      boutdata = decodeValue["data"][0];
    });
  }
}
