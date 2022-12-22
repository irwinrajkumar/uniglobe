import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniglobe/todaysassignedtickets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
//
import 'bottomnav.dart';
import 'changepassword.dart';
import 'color code.dart';
import 'main.dart';
import 'myprofile.dart';
import 'mytickets.dart';
import 'notifications.dart';
import 'ticketdetail.dart';

final TextEditingController _fromdateTimecontroller = TextEditingController();
final TextEditingController _endateTimecontroller = TextEditingController();

class totalassignedtickets extends StatefulWidget {
  const totalassignedtickets({Key? key}) : super(key: key);

  @override
  State<totalassignedtickets> createState() => _totalassignedticketsState();
}

class _totalassignedticketsState extends State<totalassignedtickets> {
  @override
  void initState() {
    super.initState();
    totaldata('', '');
  }

  var fetchdata = [];
  @override
  // DateTime _fromdateTime = DateTime.now();
  DateTime date = DateTime(1900, 07, 28);
  // DateTime date = DateTime(1900, 07, 28);

  Widget build(BuildContext context) {
    mediaSize(context);
    return Scaffold(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Total Assigned Tickets",
                                  style: TextStyle(
                                      color: greenn,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (newDate == null) return;
                                setState(() {
                                  date = newDate;
                                  _fromdateTimecontroller.text =
                                      '${date.year}-${date.month}-${date.day}';
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                width: width_ / 2.3,
                                height: height_ / 8,
                                child: TextField(
                                  controller: _fromdateTimecontroller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      // hintText:
                                      //     "${date.day}-${date.month}-${date.year}",
                                      // hintStyle: const TextStyle(
                                      //     fontSize: 12,
                                      //     height: 0.9,
                                      //     fontFamily: 'Exo2',
                                      //     color: Colors.red),
                                      suffixIcon: Align(
                                        widthFactor: 1.0,
                                        heightFactor: 1.0,
                                        child: IconButton(
                                          onPressed: () async {
                                            DateTime? newDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime.now(),
                                            );
                                            if (newDate == null) return;
                                            setState(() {
                                              date = newDate;
                                              _fromdateTimecontroller.text =
                                                  '${date.year}-${date.month}-${date.day}';
                                            });
                                          },
                                          icon:
                                              const Icon(Icons.calendar_month),
                                          iconSize: 20,
                                          color: greenn,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black12,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                        ),
                                      ),
                                      hintText: 'From Date',
                                      hintStyle: const TextStyle(
                                          fontSize: 10,
                                          height: 0.9,
                                          fontFamily: 'Exo2',
                                          color: Colors.black),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (newDate == null) return;
                                // setState(() {
                                //   _fromdateTime = newDate;
                                //   _fromdate = DateFormat('yyyy-MM-dd')
                                //       .format(_fromdateTime);
                                // });
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                width: width_ / 2.3,
                                height: height_ / 8,
                                child: TextField(
                                  controller: _endateTimecontroller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      // hintText:
                                      //     "${_fromdateTime.day}-${_fromdateTime.month}-${_fromdateTime.year}",
                                      // hintStyle: const TextStyle(
                                      //     fontSize: 12,
                                      //     height: 0.9,
                                      //     fontFamily: 'Exo2',
                                      //     color: Colors.black),
                                      suffixIcon: Align(
                                        widthFactor: 1.0,
                                        heightFactor: 1.0,
                                        child: IconButton(
                                          onPressed: () async {
                                            DateTime? newDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime.now(),
                                            );
                                            if (newDate == null) {
                                              return;
                                            } else {
                                              setState(() {
                                                date = newDate;
                                                _endateTimecontroller.text =
                                                    '${date.year}-${date.month}-${date.day}';
                                              });
                                              totaldata(
                                                  _fromdateTimecontroller.text,
                                                  _endateTimecontroller.text);
                                            }
                                          },
                                          icon:
                                              const Icon(Icons.calendar_month),
                                          iconSize: 20,
                                          color: greenn,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black12,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black12,
                                        ),
                                      ),
                                      // enabled: false,

                                      // border: OutlineInputBorder(
                                      //   borderSide: BorderSide(color: Color.fromARGB(255, 241, 233, 233),width: 1),
                                      hintText: 'To Date',
                                      hintStyle: const TextStyle(
                                          fontSize: 10,
                                          height: 0.9,
                                          fontFamily: 'Exo2',
                                          color: Colors.black),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Assigned Tickets",
                        //       style: TextStyle(
                        //           color: greenn,
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // )
                      ]),
                      Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: Column(children: [
                            Container(
                                height: height_ / 1.43,
                                width: width_,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: greenn)),
                                child: Container(
                                  height: Get.height / 1.7,
                                  // height: height_ / 1.55,
                                  // width: 360,
                                  child: ListView.builder(
                                      itemCount: fetchdata.length,
                                      // itemCount: 10,
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
                                                            Radius.circular(0)),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      new BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 1.0,
                                                      ),
                                                    ]),
                                                // color: Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
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
                                                                  fontSize: 12,
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
                                                                            ticketNumber:
                                                                                fetchdata[index]['ticket_number'].toString())),
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
                                                                color: greenn),
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
                                                              ),
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
                                      }),
                                )),
                          ])),
                    ])))));
  }

  Future<void> totaldata(formdate, todate) async {
    var baseurl = '${baseUrl}total_assigned_ticket';
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userID = pref.getString('userid');
    var url = Uri.parse(baseurl);
    final response = await http.post(url, headers: <String, String>{
      'x-api-key': token,
    }, body: {
      'user_id': '$userID',
      'from_date': formdate,
      'to_date': todate,
    });

    var decodeValue = json.decode(response.body);
    setState(() {
      fetchdata = decodeValue["data"]["total_ticket"];
    });
  }
}
