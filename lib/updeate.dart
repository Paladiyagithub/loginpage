import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage/sharep.dart';
import 'package:loginpage/thirdpage.dart';

class update extends StatefulWidget {
  Productdata vw;

  update(this.vw);

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  TextEditingController oldp = TextEditingController();
  TextEditingController cp = TextEditingController();
  TextEditingController dc = TextEditingController();
  TextEditingController pn = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  bool im = false;
  String imagepath = "";

  bool crp = false;
  bool op = false;
  bool de = false;
  bool pn1 = false;

  String drop = "Men Fashion";
  var list = [
    "Men Fashion",
    "Women Fashion",
    "Home & Living",
    "Kids & Toys",
    "Mobiles & Tablets",
    "Consumer Electronics",
    "Kids",
    "Health & Wellness"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: 170,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white54)),
                  margin: EdgeInsets.only(top: 20),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: pic.length + 1,
                      itemBuilder: (context, index) {
                        return index < pic.length
                            ? Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  img(index),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (index < oldphoto.length) {
                                          oldphoto.removeAt(index);
                                          pic = oldphoto + newphoto;
                                        } else if (index >= oldphoto.length) {
                                          newphoto.removeAt(
                                              index - oldphoto.length);
                                          pic = oldphoto + newphoto;
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 25,
                                      margin: EdgeInsets.all(10),
                                      child: Icon(Icons.close,
                                          color: Colors.white54),
                                      decoration: BoxDecoration(
                                          color: Colors.white54,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  )
                                ],
                              )
                            : InkWell(
                                onTap: () async {
                                  final XFile? image = await _picker.pickImage(
                                      source: ImageSource.gallery);

                                  setState(() {
                                    imagepath = image!.path;
                                    newphoto.add(imagepath);
                                    pic = oldphoto + newphoto;
                                    print(
                                        "================================${imagepath}");
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          style: BorderStyle.solid,
                                          color: Colors.white54)),
                                  child: Icon(
                                    Icons.add,
                                    size: 50,
                                    color: Colors.white54,
                                  ),
                                ),
                              );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 360,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(5)),
                      margin: EdgeInsets.all(15),
                      child: DropdownButton(
                        itemHeight: 50,
                        isExpanded: true,
                        // elevation: 10,
                        underline: SizedBox(),
                        dropdownColor: Colors.black,
                        value: drop,
                        items: list.map((String list) {
                          return DropdownMenuItem(
                              value: list,
                              child: Text(
                                list,
                                style: TextStyle(color: Colors.white54),
                              ));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            drop = "$value";
                            print(drop);
                          });
                        },
                      ),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30, left: 15, right: 15),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    style: TextStyle(fontSize: 17, color: Colors.white),
                    controller: pn,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 15),
                        errorText: pn1 ? " Enter Product Name" : null,
                        labelText: "Product Name",
                        labelStyle:
                            TextStyle(color: Colors.white54, fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 30, left: 15, right: 15),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          style: TextStyle(fontSize: 17, color: Colors.white),
                          controller: cp,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.currency_rupee,
                                color: Colors.white54,
                              ),
                              errorStyle: TextStyle(fontSize: 15),
                              errorText: crp ? " Enter Current Price" : null,
                              labelText: "Current Price",
                              labelStyle: TextStyle(
                                  color: Colors.white54, fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 30, left: 15, right: 15),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          style: TextStyle(fontSize: 17, color: Colors.white),
                          controller: oldp,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.currency_rupee,
                                color: Colors.white54,
                              ),
                              errorStyle: TextStyle(fontSize: 15),
                              errorText: op ? " Enter old price" : null,
                              labelText: "Old Price",
                              labelStyle: TextStyle(
                                color: Colors.white54,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30, left: 15, right: 15),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    maxLines: 5,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                    controller: dc,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 15),
                        errorText: de ? " Enter Description" : null,
                        labelText: "Description",
                        labelStyle:
                            TextStyle(color: Colors.white54, fontSize: 20),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        String oldpr = oldp.text;
                        String cp1 = cp.text;
                        String dec = dc.text;
                        String pn2 = pn.text;

                        crp = false;
                        op = false;
                        de = false;
                        pn1 = false;
                        if (pn2.isEmpty) {
                          setState(() {
                            pn1 = true;
                          });
                        } else if (cp1.isEmpty) {
                          setState(() {
                            crp = true;
                          });
                        } else if (oldpr.isEmpty) {
                          setState(() {
                            op = true;
                          });
                        } else if (dec.isEmpty) {
                          setState(() {
                            de = true;
                          });
                        } else {
                          EasyLoading.show();

                          var imagelist = [];
                          for (int i = 0; i < newphoto.length; i++) {
                            List<int> imageBytes =
                                File(newphoto[i]).readAsBytesSync();
                            imagelist.add(base64Encode(imageBytes));
                            print("[[[[[][[][====][]${imagelist[i]}");
                          }

                          Map map = {
                            "id": widget.vw.id,
                            "menu": drop,
                            "productname": pn2,
                            "currentprice": cp1,
                            "oldprice": oldpr,
                            "description": dec,
                            "oldphoto": oldphoto.isEmpty ? "" : oldphoto.toString(),
                            "newphoto": newphoto.isEmpty ? "" : imagelist.toString(),
                          };

                          print("===$map");

                          var url = Uri.parse(
                              'https://shrey12.000webhostapp.com/demoapi/update.php');
                          var response = await http.post(url, body: map);
                          print('Response status: ${response.statusCode}');
                          print('123Response body: ${response.body}');

                          EasyLoading.dismiss();
                          Future.delayed(Duration(seconds: 3)).then((value) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return third();
                              },
                            ));
                          });
                          EasyLoading.showSuccess("Updated");
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        child: Text(
                          "Update",
                          style: TextStyle(fontSize: 18, color: Colors.white54),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<String> newphoto = [];
  List<String> pic = [];
  List<String> oldphoto = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    drop = widget.vw.menu!;
    pn.text = widget.vw.productname!;
    cp.text = widget.vw.currentprice!;
    oldp.text = widget.vw.oldprice!;
    dc.text = widget.vw.description!;
    oldphoto = widget.vw.image!.split(",");
    pic = oldphoto;
  }

  img(int index) {
    if (index < oldphoto.length) {
      print("++++++++++++++++++++${oldphoto[index]}");
      return Container(
        margin: EdgeInsets.all(15),
        child: Image.network(
          "https://shrey12.000webhostapp.com/demoapi/${oldphoto[index]}",
          width: 100,
          height: 100,
        ),
      );
    } else {
      print("===================${pic[index]}");
      return Container(
        margin: EdgeInsets.all(15),
        child: Image.file(
          File("${pic[index]}"),
          width: 100,
          height: 100,
        ),
      );
    }
  }
}

class updatedata {
  int? connection;
  int? result;
  List<Details>? details;

  updatedata({this.connection, this.result, this.details});

  updatedata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? id;
  String? userid;
  String? menu;
  String? productname;
  String? currentprice;
  String? oldprice;
  String? description;
  String? image;

  Details(
      {this.id,
      this.userid,
      this.menu,
      this.productname,
      this.currentprice,
      this.oldprice,
      this.description,
      this.image});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    menu = json['menu'];
    productname = json['productname'];
    currentprice = json['currentprice'];
    oldprice = json['oldprice'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['menu'] = this.menu;
    data['productname'] = this.productname;
    data['currentprice'] = this.currentprice;
    data['oldprice'] = this.oldprice;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
