// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:uniglobe/homepage.dart';
import 'package:uniglobe/todaysassignedtickets.dart';

import 'bottomnav.dart';
import 'changepassword.dart';
import 'color code.dart';
import 'myprofile.dart';
import 'mytickets.dart';
import 'notifications.dart';

class ticketdetailandattend extends StatefulWidget {
  const ticketdetailandattend({Key? key}) : super(key: key);

  @override
  State<ticketdetailandattend> createState() => _ticketdetailandattendState();
}

class _ticketdetailandattendState extends State<ticketdetailandattend> {
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
                        "Ticket Details",
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
                        height: height_ / 1.55,
                        width: width_,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: greenn)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: height_ / 1.65,
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
                                        children: [
                                          Text('Pc Not Responding',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Ticket Description :'),
                                        SizedBox(
                                            width: width_ / 1.9,
                                            child: Text(
                                                'pc runs very slow not respond-ing immediately not able to open adobe files, aftereffects not able to open.')),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text('Assign Date: ',
                                              style: TextStyle(fontSize: 16)),
                                          Text('21-04-2022',
                                              style: TextStyle(
                                                color: greenn,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Status: ',
                                                  style:
                                                      TextStyle(fontSize: 16))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              DropdownButton(
                                                focusColor: whitegrey,
                                                // Initial Value
                                                value: dropdownvalue,

                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),

                                                // Array list of items
                                                items:
                                                    items.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(
                                                      ' Not Attended           ',
                                                      style: TextStyle(
                                                          color: reded),
                                                    ),
                                                  );
                                                }).toList(),
                                                // hint: Text(""),

                                                // After selecting the desired option,it will
                                                // change button value to selected value
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    dropdownvalue = newValue!;
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Divider(
                                        height: 20,
                                        thickness: 1.1,
                                        indent: 20,
                                        endIndent: 0,
                                        color: greenn,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [Text('Description')],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DottedBorder(
                                        color: greenn,
                                        // gap: 3,
                                        strokeWidth: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 10),
                                          child: TextFormField(
                                            minLines: 2,
                                            maxLines: 5,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: InputDecoration(
                                                hintText: '  Type here...',
                                                // hintStyle: TextStyle(
                                                //     color: Colors.grey),
                                                // border: OutlineInputBorder(
                                                //   borderRadius:
                                                //       BorderRadius.all(
                                                //           Radius.circular(
                                                //               20.0)
                                                //               ),
                                                // ),
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width_ / 1.25,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: greenn),
                                            onPressed: (() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        home()),
                                              );
                                            }),
                                            child: Text('SUBMIT'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])),
              ]),
            ),
          ),
        ));
  }
}
