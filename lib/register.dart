import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'main.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final ImagePicker _picker = ImagePicker();

  String imagepath = "";
  bool pass = true;

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  bool img = false;
  bool namee = false;
  bool numberr = false;
  bool emaill = false;
  bool passwordd = false;
  bool datee = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);

                      setState(() {
                        imagepath = image!.path;
                      });
                      if (imagepath != "") {
                        setState(() {
                          img = true;
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: img
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(File(imagepath)),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white54,
                            ),
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 30, left: 40, right: 40),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  controller: name,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white54,
                      ),
                      errorStyle: TextStyle(fontSize: 15),
                      errorText: namee ? " Enter your Name" : null,
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.white54),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 30, left: 40, right: 40),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
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
                margin: EdgeInsets.only(bottom: 30, left: 40, right: 40),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  controller: password,
                  obscureText: pass,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.white54,
                      ),
                      errorStyle: TextStyle(fontSize: 15),
                      errorText: passwordd ? "Enter your Password" : null,
                      labelText: "Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (pass == true) {
                                pass = false;
                              } else {
                                pass = true;
                              }
                            });
                          },
                          icon: pass
                              ? Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white54,
                                )
                              : Icon(Icons.remove_red_eye_outlined,
                                  color: Colors.white54)),
                      labelStyle: TextStyle(color: Colors.white54),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 30, left: 40, right: 40),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  controller: dateInput,
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                dateInput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.white54,
                          )),
                      errorStyle: TextStyle(fontSize: 15),
                      errorText: datee ? "Enter date" : null,
                      hintText: "YYYY-MM-DD",
                      hintStyle: TextStyle(color: Colors.white54),
                      labelText: "Enter Date",
                      labelStyle: TextStyle(color: Colors.white54),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white54)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 30, left: 40, right: 40),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.numberWithOptions(),
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  controller: number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mobile_friendly,
                        color: Colors.white54,
                      ),
                      errorStyle: TextStyle(fontSize: 15),
                      errorText: numberr ? "Enter Number" : null,
                      labelText: "Number",
                      labelStyle: TextStyle(color: Colors.white54),
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
                      String name1 = name.text;
                      String email1 = email.text;
                      String pass1 = password.text;
                      String number1 = number.text;
                      String date1 = dateInput.text;

                      namee = false;
                      numberr = false;
                      emaill = false;
                      datee = false;
                      passwordd = false;

                      if (name1.isEmpty) {
                        setState(() {
                          namee = true;
                        });
                      } else if (email1.isEmpty) {
                        setState(() {
                          emaill = true;
                        });
                      } else if (pass1.isEmpty) {
                        setState(() {
                          passwordd = true;
                        });
                      } else if (date1.isEmpty) {
                        setState(() {
                          datee = true;
                        });
                      } else if (number1.isEmpty) {
                        setState(() {
                          numberr = true;
                        });
                      } else {
                        EasyLoading.show();
                        List<int> imageBytes =
                            File(imagepath).readAsBytesSync();
                        String imagedata = base64Encode(imageBytes);

                        Map map = {
                          "name": name1,
                          "email": email1,
                          "password": pass1,
                          "number": number1,
                          "dob": date1,
                          "imagedata": imagedata
                        };

                        print("===$map");

                        var url = Uri.parse(
                            'https://shrey12.000webhostapp.com/demoapi/register.php');
                        var response = await http.post(url, body: map);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        EasyLoading.dismiss();
                        Future.delayed(Duration(seconds: 3)).then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return loginpage();
                          },));
                        });
                        EasyLoading.showSuccess("Success");
                      }
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 50,
                        width: 130,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade500,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Sing up",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  EasyLoading.show();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return loginpage();
                    },
                  ));
                  EasyLoading.dismiss(animation: true);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Text(
                        "Login youre Account",
                        style: TextStyle(
                            fontSize: 16, color: Colors.blue.shade600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
