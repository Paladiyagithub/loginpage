import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginpage/main.dart';
import 'package:loginpage/sharep.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage/updeate.dart';
import 'package:loginpage/viewproduct.dart';

class third extends StatefulWidget {
  const third({Key? key}) : super(key: key);

  @override
  State<third> createState() => _thirdState();
}

class _thirdState extends State<third> {
  String imge = "";
  String name = "";
  String email = "";

  bool app = true;

  int cnt = 0;
  List<Widget> ll = [view(), add(), viewupl()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    img();
  }

  void img() {
    setState(() {
      imge = share.sp!.getString("image") ?? "";
      name = share.sp!.getString("name") ?? "";
      email = share.sp!.getString("email") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app
          ? AppBar(
              title: Text("View Product"),
            )
          : AppBar(
              title: Text("Uplode Product"),
            ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                      otherAccountsPictures: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://shrey12.000webhostapp.com/demoapi/$imge"),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://shrey12.000webhostapp.com/demoapi/$imge"),
                        ),
                      ],
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://shrey12.000webhostapp.com/demoapi/$imge"),
                      ),
                      accountName: Text("$name"),
                      accountEmail: Text("$email")),
                  Card(
                    elevation: 10,
                    color: Colors.white54,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          cnt = 0;
                          app = true;
                          Navigator.pop(context);
                        });
                      },
                      leading: Icon(Icons.shopping_cart_outlined,
                          color: Colors.white54),
                      title: Text(
                        "View Products",
                        style: TextStyle(color: Colors.white54, fontSize: 17),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    color: Colors.white54,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          cnt = 1;
                          app = false;
                          Navigator.pop(context);
                        });
                      },
                      leading:
                          Icon(Icons.add_shopping_cart, color: Colors.white54),
                      title: Text(
                        "Add Products",
                        style: TextStyle(color: Colors.white54, fontSize: 17),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    color: Colors.white54,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          cnt = 2;
                          Navigator.pop(context);
                        });
                      },
                      leading: Icon(Icons.shopping_cart_outlined,
                          color: Colors.white54),
                      title: Text(
                        "View youre Uplode Products",
                        style: TextStyle(color: Colors.white54, fontSize: 17),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    color: Colors.white54,
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.settings, color: Colors.white54),
                      title: Text(
                        "Setting",
                        style: TextStyle(color: Colors.white54, fontSize: 17),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    color: Colors.white54,
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.help, color: Colors.white54),
                      title: Text(
                        "'Help and Feedback'",
                        style: TextStyle(color: Colors.white54, fontSize: 17),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Divider(),
                        Card(
                          color: Colors.white54,
                          child: ListTile(
                              onTap: () {
                                EasyLoading.show();
                                Future.delayed(Duration(seconds: 2))
                                    .then((value) {
                                  EasyLoading.dismiss();
                                  EasyLoading.showSuccess("Success!");
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return loginpage();
                                    },
                                  ));
                                });

                                share.sp!.setBool("demo", false);
                              },
                              leading: Icon(
                                Icons.settings,
                                color: Colors.white54,
                              ),
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 17),
                              )),
                        ),
                      ],
                    ))))
          ],
        ),
      ),
      body: ll[cnt],
    );
  }
}

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List<Details> vi = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: ListView.builder(
            itemCount: vi.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white54,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return vip(vi,index);
                          },
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        // alignment: Alignment.center,
                        color: Colors.black,
                        height: 100,
                        width: 100,
                        child: Image.network(
                            "https://shrey12.000webhostapp.com/demoapi/${vi[index].image!.split(",")[0]}"),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        // alignment: Alignment.topLeft,
                        height: 100,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${vi[index].productname}",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 10),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      "${vi[index].description}",maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white54, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${vi[index].menu}",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 19),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 18,
                                  margin: EdgeInsets.only(right: 3),
                                  child: Text(
                                    "₹",
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 10),
                                  ),
                                ),
                                Text(
                                  "${vi[index].currentprice}",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 18),
                                ),
                                Container(
                                    alignment: Alignment.bottomCenter,
                                    height: 18,
                                    // color: Colors.black,
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "${vi[index].oldprice}",
                                      style: TextStyle(decoration: TextDecoration.lineThrough,
                                          color: Colors.white54, fontSize: 10),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.show();
    viewpro();
    EasyLoading.dismiss();
    EasyLoading.showSuccess("Success...");
  }

  Future<void> viewpro() async {
    var url =
        Uri.parse('https://shrey12.000webhostapp.com/demoapi/viewproduct.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var l = jsonDecode(response.body);
    viewproduct vp = viewproduct.fromJson(l);

    setState(() {
      vi = vp.details!;
    });
  }
}

class viewproduct {
  int? connection;
  int? result;
  List<Details>? details;

  viewproduct({this.connection, this.result, this.details});

  viewproduct.fromJson(Map<String, dynamic> json) {
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

class add extends StatefulWidget {
  const add({Key? key}) : super(key: key);

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  TextEditingController oldp = TextEditingController();
  TextEditingController cp = TextEditingController();
  TextEditingController dc = TextEditingController();
  TextEditingController pn = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  bool im = false;
  String imagepath = "";
  List addphoto = [];

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
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.show(indicator: Text("Loding...")).then((value) => Duration(seconds: 3));
    
    EasyLoading.dismiss();
    EasyLoading.showSuccess("Success");
  }
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
                      itemCount: addphoto.length + 1,
                      itemBuilder: (context, index) {
                        return index == addphoto.length
                            ? InkWell(
                                onTap: () async {
                                  final XFile? image = await _picker.pickImage(
                                      source: ImageSource.gallery);

                                  setState(() {
                                    imagepath = image!.path;
                                    addphoto.add(imagepath);
                                    print("+++++++++++++____________)$addphoto");

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
                              )
                            : Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 100,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white54, width: 1),
                                        image: DecorationImage(
                                            image: FileImage(
                                                File(addphoto[index])))),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        addphoto.removeAt(index);
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
                          for (int i = 0; i < addphoto.length; i++) {
                            List<int> imageBytes =
                                File(addphoto[i]).readAsBytesSync();
                            imagelist.add(base64Encode(imageBytes));
                          }

                          String loginid = share.sp!.getString("id") ?? "";
                          print("1234567890$loginid");
                          Map map = {
                            "loginid": loginid,
                            "menu": drop,
                            "productname": pn2,
                            "currentprice": cp1,
                            "oldprice": oldpr,
                            "description": dec,
                            "image": imagelist.toString(),
                            "imagelength": addphoto.length.toString()
                          };

                          print("===$map");

                          var url = Uri.parse(
                              'https://shrey12.000webhostapp.com/demoapi/addproduct.php');
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
                          EasyLoading.showSuccess("Success");
                          addphoto = [];
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        child: Text(
                          "Add Product",
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
}

class viewupl extends StatefulWidget {
  const viewupl({Key? key}) : super(key: key);

  @override
  State<viewupl> createState() => _viewuplState();
}

class _viewuplState extends State<viewupl> {
  viewproduct? vp;
  bool st = false;
  List<Productdata> vw = [];
  String? aid;
  List delete = [];
  List image = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: st
            ? Container(
                child: Text("Nothing?"),
              )
            : Scaffold(
                backgroundColor: Colors.black,
                body: Container(
                  child: ListView.builder(
                    itemCount: vw.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white54,
                        child: Slidable(
                          endActionPane:
                              ActionPane(motion: ScrollMotion(), children: [
                            SlidableAction(
                              onPressed: (context) async {
                                aid = delete[index].id.toString();
                                Map map = {"id": aid};
                                print(aid);

                                var url = Uri.parse(
                                    'https://shrey12.000webhostapp.com/demoapi/deletepro.php');
                                var response = await http.post(url, body: map);
                                print(
                                    'Response status: ${response.statusCode}');
                                print('Response body: ${response.body}');

                                viewuplode();


                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                  return update(vw[index]);
                                },));
                              },
                              backgroundColor: Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                          ]),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                // alignment: Alignment.center,
                                color: Colors.black,
                                height: 100,
                                width: 100,
                                child: Image.network(
                                    "https://shrey12.000webhostapp.com/demoapi/${vw[index].image!.split(",")[0]}"),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  // alignment: Alignment.topLeft,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${vw[index].productname}",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                "${vw[index].description}",maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${vw[index].menu}",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 19),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 18,
                                            margin: EdgeInsets.only(right: 3),
                                            child: Text(
                                              "₹",
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 10),
                                            ),
                                          ),
                                          Text(
                                            "${vw[index].currentprice}",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 18),
                                          ),
                                          Container(
                                              alignment: Alignment.bottomCenter,
                                              height: 18,
                                              // color: Colors.black,
                                              margin: EdgeInsets.only(left: 10),
                                              child: Text(
                                                "${vw[index].oldprice}",
                                                style: TextStyle(decoration: TextDecoration.lineThrough,
                                                    color: Colors.white54,
                                                    fontSize: 10),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.show().then((value) => Duration(seconds: 3));
    viewuplode();
    EasyLoading.showSuccess("Success...");
  }

  String id = "";

  Future<void> viewuplode() async {
    setState(() {
      id = share.sp!.getString("id") ?? "";
    });

    Map map = {"id": id};

    print("==================$map");
    var url =
        Uri.parse('https://shrey12.000webhostapp.com/demoapi/viewuplode.php');
    var response = await http.post(url, body: map);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var l = jsonDecode(response.body);

    setState(() {
      uplodepro up = uplodepro.fromJson(l);
      vw = up.productdata!;
      delete = up.productdata!;
    });

  }
}

class uplodepro {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  uplodepro({this.connection, this.result, this.productdata});

  uplodepro.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? id;
  String? userid;
  String? menu;
  String? productname;
  String? currentprice;
  String? oldprice;
  String? description;
  String? image;

  Productdata(
      {this.id,
      this.userid,
      this.menu,
      this.productname,
      this.currentprice,
      this.oldprice,
      this.description,
      this.image});

  Productdata.fromJson(Map<String, dynamic> json) {
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
