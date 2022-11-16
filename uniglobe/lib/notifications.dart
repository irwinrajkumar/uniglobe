import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'color code.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  // String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  // final List<String> weight = [
  //   'Manual Weight',
  //   'Direct Weight',
  // ];
  // String? weightValue;
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var notifications = [];
  var items = [
    'New message 1',
    'New message 2',
    'New message 3',
    'New message 4',
    'New message 5',
  ];
  @override
  void initState() {
    notification();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        // drawer: NavigationDrawerWidget(),
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
          actions: [],
          // centerTitle: true,
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
                              "Notification",
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
                                height: height_ / 1.25,
                                width: width_ / 1,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: greenn)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    child: ListView.builder(
                                        itemCount: notifications.length,
                                        // itemCount: 10,
                                        shrinkWrap: true,
                                        // physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (contect) =>
                                                    AlertDialog(
                                                  title: Text(notifications[1]
                                                      ['description']),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('CANCEL'),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                    TextButton(
                                                        child: Text('VIEW'),
                                                        onPressed: () async {
                                                          //   var pref = await SharedPreferences.getInstance();
                                                          //   await pref.clear();
                                                          //   Navigator.of(context).pushReplacement(
                                                          //     CupertinoPageRoute(builder: (context) => login()),
                                                          //   );
                                                          // },
                                                        }),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Card(
                                              elevation: 5,
                                              shape: Border(
                                                  right: BorderSide(
                                                      color: Colors.red,
                                                      width: 5)),
                                              child: ListTile(
                                                title: Text(notifications[0]
                                                        ['title']
                                                    .toString()),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ))
                          ]))
                    ])))));
  }

  Future<void> notification() async {
    var baseurl = '${baseUrl}notification';

    var url = Uri.parse(baseurl);
    final response = await http.post(url, headers: <String, String>{
      'x-api-key': token,
    }, body: {
      'page': 'notification',
    });

    var decodeValue = json.decode(response.body);
    setState(() {
      print(decodeValue['status']);
      notifications = decodeValue['data']['notification'];
      print(notifications.toString());
    });
  }
}
