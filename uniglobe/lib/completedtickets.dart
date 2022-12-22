import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniglobe/mytickets.dart';
import 'package:uniglobe/todaysassignedtickets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'bottomnav.dart';
import 'changepassword.dart';
import 'color code.dart';
import 'main.dart';
import 'myprofile.dart';
import 'notifications.dart';
import 'ticketdetail.dart';

class completedtickets extends StatefulWidget {
  const completedtickets({Key? key}) : super(key: key);

  @override
  State<completedtickets> createState() => _completedticketsState();
}

class _completedticketsState extends State<completedtickets> {
  @override
  void initState() {
    super.initState();
    compeletedata();
  }

  var fetchdata = [];
  @override
  Widget build(BuildContext context) {
    mediaSize(context);
    return Scaffold(
        backgroundColor: whitegrey,
        drawer: DrawerWidget(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                icon: const Image(
                  image: AssetImage("assets/menu.png"),
                  // width: 30,
                ),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
          actions: [
            IconButton(
                icon: const Image(
                  image: AssetImage("assets/bellsolid.png"),
                  // width: 24,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => notification()));
                }),
          ],
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
                              "Completed Tickets",
                              style: TextStyle(
                                  color: greenn,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ]),
                      Padding(
                          padding: const EdgeInsets.only(right: 20, top: 40),
                          child: Column(children: [
                            Container(
                                height: height_ / 1.30,
                                width: width_,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: greenn)),
                                child: Container(
                                    // height: Get.height / 1.7,
                                    height: height_ / 1.55,
                                    // width: 360,
                                    child: ListView.builder(
                                        itemCount: fetchdata.length,
                                        // itemCount: 10,
                                        shrinkWrap: true,
                                        // physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  width: width_ / 1.2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  0)),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        new BoxShadow(
                                                          color: Colors.black,
                                                          blurRadius: 1.0,
                                                        ),
                                                      ]),
                                                  // color: Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Ticket No: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  fetchdata[index]
                                                                          [
                                                                          'ticket_number']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          greenn),
                                                                ),
                                                              ],
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ticketdetail(
                                                                            type:"Complete",
                                                                              ticketNumber: fetchdata[index]['ticket_number'].toString())),
                                                                );
                                                              },
                                                              child: Text(
                                                                'View',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Ticket Tittle: ",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            Text(
                                                              fetchdata[index][
                                                                      'ticket_title']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color:
                                                                      greenn),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Assigned No: ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  fetchdata[index]
                                                                          [
                                                                          'ticket_raised_dt']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          greenn),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  fetchdata[index]
                                                                          [
                                                                          'ticked_status']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          greenn),
                                                                ),
                                                                Image.asset(
                                                                  "assets/tick.png",
                                                                  width: 20,
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                //
                                              ),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          );
                                        })))
                          ]))
                    ])))));
  }

  Future<void> compeletedata() async {
    var baseurl = '${baseUrl}completed_ticket';
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userID = pref.getString('userid');
    var url = Uri.parse(baseurl);
    final response = await http.post(url, headers: <String, String>{
      'x-api-key': token,
    }, body: {
      'user_id': '$userID',
    });

    var decodeValue = json.decode(response.body);
    setState(() {
      fetchdata = decodeValue["data"]["pending_ticket"];
    });
  }
}
