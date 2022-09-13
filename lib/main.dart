import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loginpage/register.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:loginpage/sharep.dart';
import 'package:loginpage/thirdpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lottie.dart';

void main() {
  runApp(MaterialApp(
    builder: EasyLoading.init(),
    home: lottie(),
  ));
}

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool emaill = false;
  bool passs = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    network();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Text(
                "Sing in",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 30, left: 40, right: 40),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: TextField(
                style: TextStyle(fontSize: 17, color: Colors.white),
                controller: email,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.white54,
                    ),
                    errorStyle: TextStyle(fontSize: 15),
                    errorText: emaill ? " Enter your Email" : null,
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white54),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10, left: 40, right: 40),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: TextField(
                style: TextStyle(fontSize: 17, color: Colors.white),
                controller: password,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white54,
                    ),
                    errorStyle: TextStyle(fontSize: 15),
                    errorText: passs ? "Enter Password" : null,
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white54),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.blue.shade600),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                EasyLoading.show();
                Future.delayed(Duration(seconds: 2)).then((value) {
                  EasyLoading.dismiss();
                  EasyLoading.showSuccess("Success!");
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return register();
                    },
                  ));
                });
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25, left: 50),
                    child: Text(
                      "Create new account",
                      style:
                          TextStyle(fontSize: 16, color: Colors.blue.shade600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 100,
        child: FloatingActionButton(
          backgroundColor: Colors.blue.shade400,
          onPressed: () async {
            String email1 = email.text;
            String password1 = password.text;

            emaill = false;
            passs = false;

            if (email1.isEmpty) {
              setState(() {
                emaill = true;
              });
            } else if (password1.isEmpty) {
              setState(() {
                passs = true;
              });
            } else {
              EasyLoading.show();
              Map map = {
                "email": email.text,
                "password": password.text,
              };

              print("===$map");

              var url = Uri.parse(
                  'https://shrey12.000webhostapp.com/demoapi/loginpage.php');
              var response = await http.post(url, body: map);
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');

              var mm = jsonDecode(response.body);
              loginp ll = loginp.fromJson(mm);

              if (ll.connection == 1) {
                if (ll.result == 1) {
                  String? id = ll.userdata!.id;
                  String? name = ll.userdata!.name;
                  String? email = ll.userdata!.email;
                  String? number = ll.userdata!.number;
                  String? image = ll.userdata!.imagename;

                  share.sp!.setBool("demo", true);
                  share.sp!.setString("id", id!);
                  share.sp!.setString("name", name!);
                  share.sp!.setString("email", email!);
                  share.sp!.setString("number", number!);
                  share.sp!.setString("image", image!);

                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      EasyLoading.showSuccess("Complite");
                      return third();
                    },
                  ));
                }
              }
              else
              {
                if(ll.userdata!.email != email.text)
                {
                  Flushbar(
                    messageColor: Colors.red,
                    message: "Invalid Email",
                  ).show(context);
                }
                else if(ll.userdata!.password != password.text)
                {
                  Flushbar(
                    messageColor: Colors.red,
                    message: "Invalid Password",
                  ).show(context);
                }
                EasyLoading.dismiss();
              }

            }
          },
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Text(
            "Login",
            style: TextStyle(fontSize: 19),
          ),
        ),
      ),
    );
  }


  bool net = false;

  void network() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      net = true;
      print("mobaile$net");
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      net = true;
      print("wifi$net");
      // I am connected to a wifi network.
    } else {
      Flushbar(
        messageColor: Colors.red,
        message: "Check youre Network",
      ).show(context);
    }
  }
}

class loginp {
  int? connection;
  int? result;
  Userdata? userdata;

  loginp({this.connection, this.result, this.userdata});

  loginp.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? id;
  String? name;
  String? email;
  String? password;
  String? number;
  String? dob;
  String? imagename;

  Userdata(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.number,
      this.dob,
      this.imagename});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    number = json['number'];
    dob = json['dob'];
    imagename = json['imagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['number'] = this.number;
    data['dob'] = this.dob;
    data['imagename'] = this.imagename;
    return data;
  }
}
