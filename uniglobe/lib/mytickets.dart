import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniglobe/todaysassignedtickets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'bottomnav.dart';
import 'changepassword.dart';
import 'color code.dart';
import 'main.dart';
import 'myprofile.dart';
import 'myticketdetail.dart';
import 'notifications.dart';
import 'ticketdetail.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final TextEditingController _fromdateTimecontroller = TextEditingController();
final TextEditingController _endateTimecontroller = TextEditingController();

class mytickets extends StatefulWidget {
  const mytickets({Key? key}) : super(key: key);

  @override
  State<mytickets> createState() => _myticketsState();
}

class _myticketsState extends State<mytickets> {
  @override
  void initState() {
    super.initState();
    myticketsdata('', '');
  }

  var fetchdata = [];
  final List<String> weight = [
    'Compeleted',
    'Pending',
  ];
  String? weightValue;
  DateTime date = DateTime(1900, 07, 28);
  @override
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
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "My Tickets",
                                    style: TextStyle(
                                        color: greenn,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                    );
                                    if (newDate == null) return;
                                    // setState(() {
                                    //   _fromdateTime = newDate;
                                    //   _fromdate = DateFormat('yyyy-MM-dd')
                                    //       .format(_fromdateTime);
                                    // });
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    width: width_ / 2.3,
                                    height: height_ / 8,
                                    child: TextField(
                                      controller: _fromdateTimecontroller,
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
                                                  firstDate: DateTime(1800),
                                                  lastDate: DateTime(3000),
                                                );
                                                if (newDate == null) return;
                                                setState(() {
                                                  date = newDate;
                                                  _fromdateTimecontroller.text =
                                                      '${date.year}-${date.month}-${date.day}';
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.calendar_month),
                                              iconSize: 20,
                                              color: greenn,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
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
                                      lastDate: DateTime(2100),
                                    );
                                    if (newDate == null) return;
                                    // setState(() {
                                    //   _fromdateTime = newDate;
                                    //   _fromdate = DateFormat('yyyy-MM-dd')
                                    //       .format(_fromdateTime);
                                    // });
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                                  firstDate: DateTime(1800),
                                                  lastDate: DateTime(3000),
                                                );
                                                if (newDate == null) return;
                                                setState(() {
                                                  date = newDate;
                                                  _endateTimecontroller.text =
                                                      '${date.year}-${date.month}-${date.day}';
                                                });
                                                myticketsdata(
                                                    _fromdateTimecontroller
                                                        .text,
                                                    _endateTimecontroller.text);
                                              },
                                              icon: const Icon(
                                                  Icons.calendar_month),
                                              iconSize: 20,
                                              color: greenn,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
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
                                // SizedBox(
                                //   width: 10,
                                // ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Row(children: [
                          //   Container(
                          //     decoration: BoxDecoration(
                          //       color: const Color.fromARGB(255, 255, 255, 255),
                          //       borderRadius: BorderRadius.circular(0),

                          //       border: Border.all(color: greenn),
                          //     ),

                          //     // width: Get.width / 1.5,
                          //     //dropppp
                          //     height: 50,
                          //     width: width_ / 2.10,
                          //     child: DropdownButtonHideUnderline(
                          //       child: DropdownButton2(
                          //         isExpanded: true,
                          //         hint: Row(
                          //           children: const [
                          //             SizedBox(
                          //               width: 4,
                          //             ),

                          //             // Expanded(
                          //             //   child: Text(
                          //             //     '  Maritial Status',
                          //             //     style: TextStyle(
                          //             //       fontSize: 18,
                          //             //       fontWeight: FontWeight.bold,
                          //             //       color: Colors.grey,
                          //             //     ),
                          //             //     overflow: TextOverflow.ellipsis,
                          //             //   ),
                          //             // ),
                          //           ],
                          //         ),
                          //         items: weight
                          //             .map((payment) =>
                          //                 DropdownMenuItem<String>(
                          //                   value: payment,
                          //                   child: Text(
                          //                     "  " + payment,
                          //                     style: const TextStyle(
                          //                         fontWeight: FontWeight.bold,
                          //                         color: Colors.grey,
                          //                         fontSize: 18),
                          //                     overflow: TextOverflow.ellipsis,
                          //                   ),
                          //                 ))
                          //             .toList(),
                          //         value: weightValue,
                          //         onChanged: (value) {
                          //           // setState(() {
                          //           //   weightValue = value as String;
                          //           //   isopen = true;
                          //           //   // iscolse=true;
                          //           // }
                          //           // );
                          //           setState(() {
                          //             weightValue = value as String;
                          //             print(weightValue.toString());

                          //             // isopen = true;
                          //           });
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ])
                        ],
                      ),
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

  Future<void> myticketsdata(formdate, todate) async {
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
