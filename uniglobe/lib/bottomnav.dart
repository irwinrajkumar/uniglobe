import 'dart:convert';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniglobe/color%20code.dart';
import 'package:uniglobe/homepage.dart';
import 'package:uniglobe/login.dart';
import 'package:uniglobe/mytickets.dart';
import 'package:http/http.dart' as http;
import 'changepassword.dart';
import 'main.dart';
import 'todaysassignedtickets.dart';
import 'myprofile.dart';
// import 'package:uniglobe/homepage.dart';

class bottomsheet extends StatefulWidget {
  bottomsheet({
    Key? key,
    this.title,
  }) : super(key: key);
  final String? title;

  @override
  _bottomsheetState createState() => _bottomsheetState();
}

class _bottomsheetState extends State<bottomsheet> {
  int selectedPos = 0;
  final pages = [home(), todaysassignedtockets(), myprofile()];

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.home,
      "Home",
      Colors.green,
      labelStyle: TextStyle(
        fontWeight: FontWeight.normal,
      ),
    ),
    TabItem(
      Icons.assignment_outlined,
      "Tickets",
      Colors.green,
      labelStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.person,
      "My Profile",
      Colors.green,
    ),
  ]);

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
    initFunction();
  }

  initFunction() async {
    if (!await InternetConnectionCheckerPlus().hasConnection) {
      Fluttertoast.showToast(msg: "Please turn on network or wifi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            child: pages[selectedPos],
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: whitegrey,
      backgroundBoxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
          print(_navigationController.value);
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}

class DrawerWidget extends StatefulWidget {
  DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int _value = 0;
  // int _value1 = 0;
  var userName;
  var mobile;
  var mail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user();
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

  var profile1;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // padding: EdgeInsets.zero,
        children: [
          Container(
            height: height_ / 3.9,
            child: DrawerHeader(
                child: Column(children: [
              Image(
                image: AssetImage(
                  'assets/holiday.png',
                ),
              ),
              //
            ])),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        profile1 != null && profile1['profile_image'] != null
                            ? Image.network(profile1['profile_image'],
                                fit: BoxFit.cover, height: 60.0, width: 60.0)
                            : Image(
                                image: AssetImage(
                                  'assets/man.png',
                                ),
                              ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              userName ?? '',
                              style: const TextStyle(
                                // width:width_,

                                fontSize: 22,
                                fontFamily: "Exo2",
                                color: greenn,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            //  Text('data')
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              mail ?? '',
                              style: const TextStyle(
                                // width:width_,

                                fontSize: 15,
                                fontFamily: "Exo2",
                                color: greenn,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            //  Text('data')
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          //                    <--- top side
                          color: greenn,
                          width: 1),
                      bottom: BorderSide(
                          //                    <--- top side
                          color: greenn,
                          width: 1),
                    ),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      "assets/user.png",
                      width: 30,
                    ),
                    title: const Text('My Profile'),
                    onTap: () {
                      // Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const myprofile()),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          //                    <--- top side
                          color: greenn,
                          width: 1),
                    ),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      "assets/resetpassword.png",
                      width: 30,
                    ),
                    title: const Text('Change Password'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const changepassword()),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: greenn,
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      "assets/tickets.png",
                      width: 30,
                    ),
                    title: const Text('My Tickets'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const mytickets()),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: greenn,
                        width: 1.2,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      "assets/logout.png",
                      width: 30,
                    ),
                    title: const Text('Sign Out'),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              StatefulBuilder(builder: (context, setState) {
                                return AlertDialog(
                                  title: Container(
                                    // width: 130,
                                    decoration: BoxDecoration(
                                        // border: Border(
                                        //   bottom: BorderSide(
                                        //     //                    <--- top side
                                        //     color: greenn,
                                        //     width: 1.2,
                                        //   ),
                                        // ),
                                        ),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "Are you sure want to Logout ?",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Divider(
                                        height: 0,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                        color: greenn,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 80,
                                          child: ElevatedButton(
                                            // color: Color.fromARGB(255, 2, 228, 119),
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 40,
                                          width: 80,
                                          child: ElevatedButton(
                                            // color: Color.fromARGB(255, 2, 228, 119),
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              SharedPreferences pref =
                                                  await SharedPreferences
                                                      .getInstance();
                                              pref.clear();
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Login()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                            },
                                          ),
                                        ),
                                        // Container(
                                        //     height: 50,
                                        //     width: 80,
                                        //     decoration: BoxDecoration(
                                        //       color: Colors.white,
                                        //       borderRadius: BorderRadius.only(
                                        //           topLeft: Radius.circular(10),
                                        //           topRight: Radius.circular(10),
                                        //           bottomLeft:
                                        //               Radius.circular(10),
                                        //           bottomRight:
                                        //               Radius.circular(10)),
                                        //       // boxShadow: [
                                        //       //   BoxShadow(
                                        //       //     color: Colors.grey
                                        //       //         .withOpacity(0.5),
                                        //       //     spreadRadius: 5,
                                        //       //     blurRadius: 7,
                                        //       //     offset: Offset(0,
                                        //       //         3), // changes position of shadow
                                        //       //   ),
                                        //       // ],
                                        //     ),
                                        //     child: GestureDetector(
                                        //       onTap: () =>
                                        //           setState(() => _value = 0),
                                        //       child: Container(
                                        //         height: 96,
                                        //         width: 90,
                                        //         decoration: BoxDecoration(
                                        //           color: _value == 0
                                        //               ? greenn
                                        //               : Colors.white,
                                        //           border: Border.all(
                                        //               color: Colors.transparent,
                                        //               width: 2),
                                        //           borderRadius:
                                        //               BorderRadius.circular(12),
                                        //         ),
                                        //         child: Text("No"),
                                        //         alignment: Alignment.center,
                                        //       ),
                                        //     )),
                                        // Container(
                                        //   height: 50,
                                        //   width: 80,
                                        //   decoration: BoxDecoration(
                                        //     color: greenn,
                                        //     borderRadius: BorderRadius.only(
                                        //         topLeft: Radius.circular(10),
                                        //         topRight: Radius.circular(10),
                                        //         bottomLeft: Radius.circular(10),
                                        //         bottomRight:
                                        //             Radius.circular(10)),
                                        //     boxShadow: [
                                        //       BoxShadow(
                                        //         color: Color.fromARGB(
                                        //                 255, 130, 33, 175)
                                        //             .withOpacity(0.5),
                                        //         // spreadRadius: 5,
                                        //         blurRadius: 6,
                                        //         offset: Offset(0,
                                        //             1), // changes position of shadow
                                        //       ),
                                        //     ],
                                        //   ),
                                        //   child: GestureDetector(
                                        //     onTap: ()
                                        //     async {
                                        //       Navigator.pop(context);
                                        //       SharedPreferences pref =
                                        //           await SharedPreferences
                                        //               .getInstance();
                                        //       pref.clear();
                                        //       Navigator.of(context)
                                        //           .pushAndRemoveUntil(
                                        //               MaterialPageRoute(
                                        //                   builder: (context) =>
                                        //                       Login()),
                                        //               (Route<dynamic> route) =>
                                        //                   false);
                                        //     },

                                        //     child: Container(

                                        //       height: 96,
                                        //       width: 90,
                                        //       decoration: BoxDecoration(

                                        //         color: _value == 1
                                        //             ? greenn
                                        //             : Colors.white,
                                        //         border: Border.all(
                                        //             color: Colors.transparent,
                                        //             width: 2),
                                        //         borderRadius:
                                        //             BorderRadius.circular(12),
                                        //       ),
                                        //       child: Text("Yes"),
                                        //       alignment: Alignment.center,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                );
                              }));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //   backgroundColor: Color.fromARGB(255, 238, 237, 237),
      //   // drawer: NavBar(),
    );
  }

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
        profile1 = decodeValue["data"][0];
      }
    });
  }
}
