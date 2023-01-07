import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:uniglobe/todaysassignedtickets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'bottomnav.dart';
import 'changepassword.dart';
import 'color code.dart';
import 'end_point.dart';
import 'main.dart';
import 'myprofile.dart';
import 'mytickets.dart';
import 'notifications.dart';
import 'ticketdetailandattend.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ticketdetail extends StatefulWidget {
  var ticketNumber;
  var type;
  ticketdetail({Key? key, this.ticketNumber, this.type}) : super(key: key);

  @override
  State<ticketdetail> createState() => _ticketdetailState();
}

class _ticketdetailState extends State<ticketdetail> {
  TextEditingController Descriptionctrl = TextEditingController();
  String dropdownvalue1 = 'resolved';

  // List of items in our dropdown menu
  var list = [];
  var init = [];
  var exteriorscratchesSingleImageList;
  var inventory = [];
  var exteriorsList = [];
  var priviewImageList = [];
  var ticketimg = [];
  String? dropdownValue;
  var ticketinform;
  var status;
  bool ticket = false;

  ticketapi() async {
    var url = Uri.parse('${baseUrl}ticket_details');
    var res = await http.post(url, headers: <String, String>{
      'x-api-key': token,
    }, body: {
      'ticket_number': '${widget.ticketNumber}',
    });
    var decodeValue = json.decode(res.body);
    setState(() {
      ticket = true;
      ticketinform = decodeValue['data']['ticket_details'];
      status = decodeValue['data']['ticket_details']['ticked_status'];
      list = decodeValue['data']['status_dropdown'];

      print(decodeValue['data']['status_dropdown']);
    });
  }

  ticketimageapi() async {
    var url = Uri.parse('${baseimageupload}fetch_service_img.php');
    var res = await http.post(url, headers: <String, String>{
      'x-api-key': token,
    }, body: {
      'ticket': '${widget.ticketNumber}',
    });
    var decodeValue = json.decode(res.body);
    setState(() {
      // ticket = false;
      if (decodeValue["status"] == "Succcess") {
        priviewImageList = decodeValue['Image List'] ?? [];
      }

      print(decodeValue['Image List']);
    });
  }

  senditmsapi() async {
    var url = Uri.parse('${baseimageupload}update_ticket_detail.php');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(
      {"Content-type": "application/x-www-form-urlencoded", 'x-api-key': token},
    );

    request.fields['ticket_number'] = '${widget.ticketNumber}';
    request.fields['ticket_status'] = dropdownValue!;
    request.fields['ticket_comment'] = Descriptionctrl.text.toString();

    List<http.MultipartFile> clusterList = [];

    for (int i = 0; i < priviewImageList.length; i++) {
      if (priviewImageList[i].runtimeType.toString() == "_File" ||
          priviewImageList[i].runtimeType == XFile) {
        //   var singleImage = await http.MultipartFile.fromString(
        //       'image[]', priviewImageList[i].toString());
        //   clusterList.add(singleImage);
        // } else {
        var singleImage = http.MultipartFile.fromBytes(
            'image[]', File(priviewImageList[i].path).readAsBytesSync(),
            filename: priviewImageList[i].path);

        clusterList.add(singleImage);
      }
    }

    request.files.addAll(clusterList);

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var data = json.decode(respStr);

    if (data['status'] == true) {
      Fluttertoast.showToast(msg: data['message']);
      dropdownvalue1 = 'resolved';
      Descriptionctrl.clear();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => bottomsheet()),
          (Route<dynamic> route) => false);
    } else {
      Fluttertoast.showToast(msg: data['message']);
    }
  }

  @override
  void initState() {
    ticketapi();
    ticketimageapi();
    super.initState();
  }

  Future cameraPickerSource() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    priviewImageList.add(imageTemporary);
    print(imageTemporary.runtimeType);
    setState(() {
      Get.back();
    });
  }

  Future galaryPickerSource() async {
    final List<XFile> selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages.isNotEmpty) {
      priviewImageList.addAll(selectedImages);
    }

    setState(() {
      Get.back();
    });
    if (priviewImageList.isNotEmpty) {
      // imageList.add(_image);

      // imagepickers();
    }
  }

  imagePicker() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        padding: EdgeInsets.only(left: 90, top: 12, bottom: 12, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                galaryPickerSource();
              },
              icon: Icon(
                Icons.image,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                cameraPickerSource();
              },
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaSize(context);

    return Scaffold(
        drawer: DrawerWidget(),
        // resizeToAvoidBottomInset: false,
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
                child: ticket == true
                    ? Column(children: [
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
                                // height: height_ / 1,
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
                                        // height: height_ / 1.50,
                                        decoration: BoxDecoration(
                                            color: whitegrey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
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
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        ticketinform[
                                                                'ticket_raised_username'] +
                                                            ', ',
                                                        style: TextStyle(
                                                            color: greenn,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Ticket No: "),
                                                      Text(
                                                          ticketinform[
                                                              'ticket_number'],
                                                          style: TextStyle(
                                                            color: greenn,
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5, left: 8),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    ticketinform[
                                                        'department_name'],
                                                    style: TextStyle(
                                                        color: greenn,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      ticketinform[
                                                          'ticket_title'],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Ticket Description :'),
                                                  SizedBox(
                                                      width: width_ / 2,
                                                      child: Text(ticketinform[
                                                          'ticket_description'])),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, left: 8),
                                              child: Row(
                                                children: [
                                                  Text('Assign Date: ',
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                  Text(
                                                      ticketinform[
                                                          'ticket_assigned_datetime'],
                                                      style: TextStyle(
                                                        color: greenn,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, left: 10, right: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('Status: ',
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        ticketinform[
                                                            'ticked_status'],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            ticketinform['ticked_status'] ==
                                                    'In Progress'
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text('Issue: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16))
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            DropdownButton<
                                                                String>(
                                                              value:
                                                                  dropdownValue,
                                                              icon: const Icon(Icons
                                                                  .arrow_downward),
                                                              elevation: 16,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .deepPurple),
                                                              underline:
                                                                  Container(
                                                                height: 2,
                                                                color: Colors
                                                                    .deepPurpleAccent,
                                                              ),
                                                              onChanged:
                                                                  (String?
                                                                      value) {
                                                                // This is called when the user selects an item.
                                                                setState(() {
                                                                  dropdownValue =
                                                                      value;
                                                                });
                                                              },
                                                              items: list.map<
                                                                      DropdownMenuItem<
                                                                          String>>(
                                                                  (value) {
                                                                return DropdownMenuItem<
                                                                        String>(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value));
                                                              }).toList(),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : Text(''),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Divider(
                                                height: 20,
                                                thickness: 1.1,
                                                indent: 20,
                                                endIndent: 0,
                                                color: greenn,
                                              ),
                                            ),
                                            Column(children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text('Image Perviews',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                              )
                                            ]),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(children: [
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  height: height_ / 4.5,
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      border: Border.all(
                                                        color: whitegrey,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: GridView.builder(
                                                    physics: ScrollPhysics(),
                                                    itemCount:
                                                        priviewImageList.length,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            crossAxisSpacing:
                                                                10,
                                                            mainAxisSpacing: 5,
                                                            childAspectRatio:
                                                                1.8 / 1),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      var item =
                                                          priviewImageList[
                                                              index];
                                                      return Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {},
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      whitegrey,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5))),
                                                              child: item.runtimeType
                                                                              .toString() !=
                                                                          "_File" &&
                                                                      item.runtimeType !=
                                                                          XFile
                                                                  ? Image
                                                                      .network(
                                                                      baseUrlimage +
                                                                          item[
                                                                              'service_image'],
                                                                      height:
                                                                          80,
                                                                      width: 80,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Image.file(
                                                                      File(item
                                                                          .path),
                                                                      height:
                                                                          80,
                                                                      width: 80,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                            ),
                                                          ),
                                                          // InkWell(
                                                          //     onTap: () {
                                                          //       setState(() {
                                                          //         priviewImageList
                                                          //             .removeAt(
                                                          //                 index);
                                                          //       });
                                                          //     },
                                                          //     child: Icon(
                                                          //         Icons.clear))
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                                // widget.type != "Complete"
                                                //     ?
                                                ticketinform['ticked_status'] ==
                                                        'In Progress'
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary:
                                                                        bluee),
                                                            onPressed: (() {
                                                              imagePicker();
                                                            }),
                                                            child: Text(
                                                                'Choose File'),
                                                          ),
                                                        ],
                                                      )
                                                    : Container(),
                                                ticketinform['ticked_status'] ==
                                                        'In Progress'
                                                    ? Container(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      'Description')
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  DottedBorder(
                                                                color: greenn,
                                                                // gap: 3,
                                                                strokeWidth: 1,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10,
                                                                      left: 10),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        Descriptionctrl,
                                                                    minLines: 2,
                                                                    maxLines: 5,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .multiline,
                                                                    decoration: InputDecoration(
                                                                        hintText: ticketinform['designation_name'],
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
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width:
                                                                      width_ /
                                                                          1.25,
                                                                  child:
                                                                      ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            greenn),
                                                                    onPressed:
                                                                        (() {
                                                                      if (dropdownValue !=
                                                                          null) {
                                                                        senditmsapi();
                                                                      }
                                                                      // Navigator.push(
                                                                      //   context,
                                                                      //   MaterialPageRoute(
                                                                      //       builder: (context) =>
                                                                      //           ticketdetailandattend()),
                                                                      // );
                                                                    }),
                                                                    child: Text(
                                                                        'SUBMIT'),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text('History:',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold))
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  ticketinform[
                                                                          'comment']
                                                                      .toString(),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                              ]),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ])),
                        SizedBox(
                          height: 10,
                        )
                      ])
                    : SizedBox(
                        height: 500,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: greenn,
                        )),
                      )),
          ),
        ));
  }

  // void imagepickers() async {
  //   final url = Uri.parse('${baseUrl}ticket_details');
  //   var res = await http.post(url, headers: <String, String>{
  //     'x-api-key': token,
  //   });
  //   var request = http.MultipartRequest('POST', url);

  //   request.headers['Content-type'] = 'application/json';
  //   request.headers['Accept'] = 'application/json';

  //   List<http.MultipartFile> clusterList = [];

  //   for (int i = 0; i < priviewImageList.length; i++) {
  //     if (priviewImageList[i].runtimeType == String) {
  //       var singleImage = await http.MultipartFile.fromString(
  //           'exterior_three[]', priviewImageList[i].toString());
  //       clusterList.add(singleImage);
  //     } else {
  //       var singleImage = http.MultipartFile.fromBytes('exterior_three[]',
  //           File(priviewImageList[i].path).readAsBytesSync(),
  //           filename: priviewImageList[i].path);

  //       clusterList.add(singleImage);
  //     }
  //   }
  //   request.files.addAll(clusterList);

  //   print(request.fields);
  //   print(request.files);
  //   var response = await http.Response.fromStream(await request.send());
  //   if (response == null) return;
  //   final responseString = await response.body;
  //   var data = json.decode(responseString);
  // }
}
