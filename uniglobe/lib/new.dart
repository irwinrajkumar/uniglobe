// import 'package:flutter/material.dart';
// // import 'package:flutter_share/flutter_share.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// import 'About.dart';
// // import 'Contactpage.dart';
// // import 'Deliveryperson.dart';
// // import 'Privacypage.dart';
// // import 'Termpage.dart';
// void main() {
//   runApp(MaterialApp(
//     home: NavigationDrawerWidget(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
// class NavigationDrawerWidget extends StatefulWidget {
//   const NavigationDrawerWidget({Key? key}) : super(key: key);

//   @override
//   State<NavigationDrawerWidget> createState() => NavigationDrawerWidgets();
// }

// class NavigationDrawerWidgets extends State<NavigationDrawerWidget> {
//   final padding = const EdgeInsets.symmetric(horizontal: 20);

//   // Future<void> share() async {
//   //   await FlutterShare.share(
//   //       title: 'Example share',
//   //       linkUrl: 'https://flutter.dev/',
//   //       chooserTitle: 'Share D24');
//   // }

//   // var profile;

//   // _profile() async {
//   //   var prefs = await SharedPreferences.getInstance();
//   //   setState(() {
//   //     profile = prefs.getString('profile');
//   //   });
//   // }

//   // @override
//   // void initState() {
//   //   _profile();
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(children: [
//         const SizedBox(height: 60),
//         Container(
//             child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: SizedBox.fromSize(
//                   size: const Size.fromRadius(75),
//                   // child: profile != null
//                   //     ? Image.network(profile, fit: BoxFit.cover)
//                   //     : Container(),
//                 ))),
//         const SizedBox(height: 30),
//         ListTile(
//             leading: IconButton(
//                 icon: const Image(
//                     image: AssetImage("assets/Super Telebrand/Path 410.png")),
//                 onPressed: () {}),
//             title: const Text(
//               'privacy policy',
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF3D50FF)),
//             ),
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => const Privacy()),
//               // );
//             }),
//         ListTile(
//             leading: IconButton(
//                 icon: const Image(
//                     image: AssetImage("assets/Super Telebrand/Path 408.png")),
//                 onPressed: () {}),
//             title: const Text(
//               'About',
//               style: TextStyle(fontSize: 18, color: Color(0xFF3D50FF)),
//             ),
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => Aboutpage()),
//               // );
//             }),
//         ListTile(
//             leading: IconButton(
//                 icon: const Image(
//                     image: AssetImage("assets/Super Telebrand/Path 412.png")),
//                 onPressed: () {}),
//             title: const Text(
//               'Terms and Conditions',
//               style: TextStyle(fontSize: 18, color: Color(0xFF3D50FF)),
//             ),
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => const Termpage()),
//               // );
//             }),
//         ListTile(
//             leading: IconButton(
//                 icon: const Image(
//                     image: AssetImage("assets/Super Telebrand/Path 413.png")),
//                 onPressed: () {}),
//             title: const Text(
//               'Contact us',
//               style: TextStyle(fontSize: 18, color: Color(0xFF3D50FF)),
//             ),
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => const Contactpage()),
//               // );
//             }),
//         ListTile(
//             leading: IconButton(
//                 icon: const Image(
//                     image: AssetImage(
//                         "assets/Super Telebrand/supervisor_account_FILL1_wght400_GRAD0_opsz48.png")),
//                 onPressed: () {}),
//             title: const Text(
//               'Delivery Persons',
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF3D50FF)),
//             ),
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => const Deliveryperson()),
//               // );
//             }),
//         // ListTile(
//         //   leading: IconButton(
//         //       icon: const Image(
//         //           image: AssetImage("assets/Super Telebrand/Path 414.png")),
//         //       onPressed: () {}),
//         //   title: const Text(
//         //     'Share app',
//         //     style: TextStyle(fontSize: 18, color: Color(0xFF3D50FF)),
//         //   ),
//         //   onTap: share,
//         // ),
//       ]),
//     );
//   }
// }
