import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniglobe/changepassword.dart';
import 'package:uniglobe/color%20code.dart';
import 'package:uniglobe/completedtickets.dart';
import 'package:uniglobe/login.dart';
import 'package:uniglobe/myprofile.dart';
import 'package:get/get.dart';
import 'package:uniglobe/pendingtickets.dart';
import 'package:uniglobe/todaysassignedtickets.dart';

import 'bottomnav.dart';
import 'mytickets.dart';
import 'notifications.dart';
import 'totalassignedtickets.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _value = 0;
  int _value1 = 0;
  var userName;
  var mobile;
  var mail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFunction();
  }

  initFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString('username');
      mobile = pref.getString('mobile');
      mail = pref.getString('mail');
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaSize(context);
    return Scaffold(
      backgroundColor: whitegrey,
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
      // body: pages[pageIndex],
      // bottomNavigationBar: buildMyNavBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Column(children: [
                Row(
                  children: [
                    Text(
                      'Home',
                      style: TextStyle(
                          color: greenn,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Container(
                      // height: height_,
                      child: GridView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (4 / 3),
                          ),
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                if (index == 0) {
                                  //  Get.offAll("todaysassignedtockets");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const todaysassignedtockets()),
                                  );
                                } else if (index == 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          totalassignedtickets()));
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const totalassignedtickets()),
                                  // );
                                } else if (index == 2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const pendingtickets()),
                                  );
                                  // Get.to(() => pay_deliv());
                                } else if (index == 3) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const completedtickets()),
                                  );
                                  // Get.to(() => pay_comp());
                                } else if (index == 4) {
                                  // Get.offAll(() => Home());
                                }
                              },
                              // child: Card(
                              //   elevation: 12,
                              //   child: Column(
                              //     children: [
                              //       const Spacer(),
                              //       Text('data',
                              //         // gridData[index]['text']!,
                              //         textAlign: TextAlign.center,
                              //         style: const TextStyle(
                              //             fontSize: 20,
                              //             fontFamily: "Exo2",
                              //             color: Colors.black54,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              // const Spacer(),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Column(
                                  children: [
                                    const Spacer(),
                                    Image.asset(
                                      // 'assets/list.png',
                                      name[index]['img']!,
                                      // height: 45,
                                      // width: 45,
                                      // fit: BoxFit.contain
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: width_ / 2.6,
                                      child: Text(
                                        name[index]["text"]!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          // width:width_,

                                          fontSize: 15,
                                          fontFamily: "Exo2",
                                          color: greenn,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                  //     ),
                                  //   ),
                                  //   // const Spacer(),
                                  // ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List name = [
    {'img': 'assets/list.png', 'text': "Today's Assigned Tickets"},
    {'img': 'assets/listview.png', 'text': 'Total Assigned Tickets'},
    {'img': 'assets/checklist.png', 'text': 'Pending Tickets'},
    {'img': 'assets/task.png', 'text': 'Completed Tickets'},
  ];
}

// class NavigationDrawerWidget extends StatelessWidget {
//   const NavigationDrawerWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(actions: [Text('data')]),
//     );
//   }
// }
