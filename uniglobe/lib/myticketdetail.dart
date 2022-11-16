// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:uniglobe/todaysassignedtickets.dart';

import 'bottomnav.dart';
import 'changepassword.dart';
import 'color code.dart';
import 'myprofile.dart';
import 'mytickets.dart';
import 'notifications.dart';
import 'ticketdetailandattend.dart';

class myticketdetail extends StatefulWidget {
  var ticketNumber;
  myticketdetail({Key? key, this.ticketNumber}) : super(key: key);

  @override
  State<myticketdetail> createState() => _myticketdetailState();
}

class _myticketdetailState extends State<myticketdetail> {
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  int _value = 0;
  int _value1 = 0;
  @override
  Widget build(BuildContext context) {
    mediaSize(context);
    return Scaffold(
        drawer: DrawerWidget(), // resizeToAvoidBottomInset: false,
        // drawer: NavigationDrawerWidget(),
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
                          "My Ticket Details",
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
                          height: height_ / 1.45,
                          width: width_,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: greenn)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: height_ / 1.50,
                                  decoration: BoxDecoration(
                                      color: whitegrey,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: const Offset(
                                            1.0,
                                            1.0,
                                          ),
                                          blurRadius: 2.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Arshath ,IT',
                                                  style: TextStyle(
                                                      color: greenn,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Ticket No:"),
                                                Text(" 210401",
                                                    style: TextStyle(
                                                      color: greenn,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text('Problem        : ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('Pc Not Responding',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text('Assign Date: ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('21-04-2022',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text('Status          : ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('Attended ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text('Issue            : ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('On Processing ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceEvenly,
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.start,
                                      //     children: [
                                      //       Text('Ticket Discription : ',style: TextStyle(fontWeight:
                                      //                   FontWeight.bold),),
                                      //       SizedBox(
                                      //           width: width_ / 2.1,
                                      //           child: Text(
                                      //               'pc runs very slow not respond-ing immediately not able to open adobe files, aftereffects not able to open.')),
                                      //     ],
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text('Ticket Discription: ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "pc runs very slow not respond-ing immediately not able to open adobe files, aftereffects not able to open.",
                                              textAlign: TextAlign.left,
                                            )
                                          ],
                                        ),
                                      ),

                                      // Padding(
                                      //   padding:
                                      //       const EdgeInsets.only(right: 20),
                                      //   child: Divider(
                                      //     height: 20,
                                      //     thickness: 1.1,
                                      //     indent: 20,
                                      //     endIndent: 0,
                                      //     color: greenn,
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text('History:',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                              textAlign: TextAlign.left,
                                            )
                                          ],
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: DottedBorder(
                                      //     color: greenn,
                                      //     // gap: 3,
                                      //     strokeWidth: 1,
                                      //     child: Padding(
                                      //       padding: const EdgeInsets.only(
                                      //           bottom: 10, left: 10),
                                      //       child: TextFormField(
                                      //         minLines: 2,
                                      //         maxLines: 5,
                                      //         keyboardType:
                                      //             TextInputType.multiline,
                                      //         decoration: InputDecoration(
                                      //             hintText: '  Type here...',
                                      //             // hintStyle: TextStyle(
                                      //             //     color: Colors.grey),
                                      //             // border: OutlineInputBorder(
                                      //             //   borderRadius:
                                      //             //       BorderRadius.all(
                                      //             //           Radius.circular(
                                      //             //               20.0)
                                      //             //               ),
                                      //             // ),
                                      //             border: InputBorder.none),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: [
                                      //     Container(
                                      //       width: width_ / 1.25,
                                      //       child: ElevatedButton(
                                      //         style: ElevatedButton.styleFrom(
                                      //             primary: greenn),
                                      //         onPressed: (() {
                                      //           Navigator.push(
                                      //             context,
                                      //             MaterialPageRoute(
                                      //                 builder: (context) =>
                                      //                     ticketdetailandattend()),
                                      //           );
                                      //         }),
                                      //         child: Text('SUBMIT'),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ])),
                  SizedBox(
                    height: 30,
                  )
                ])),
          ),
        ));
  }
}
