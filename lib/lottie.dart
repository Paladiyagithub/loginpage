import 'package:flutter/material.dart';
import 'package:loginpage/sharep.dart';
import 'package:loginpage/thirdpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'main.dart';

class lottie extends StatefulWidget {
  const lottie({Key? key}) : super(key: key);

  @override
  State<lottie> createState() => _lottieState();
}

class _lottieState extends State<lottie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("lottie/92029-cart-empty.json"),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharep();
  }

  Future<void> sharep() async {
    share.sp = await SharedPreferences.getInstance();
    bool spdata = share.sp!.getBool("demo") ?? false;

    if (spdata) {
      Future.delayed(Duration(seconds: 3)).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return third();
          },
        ));
      });
    } else {
      Future.delayed(Duration(seconds: 3)).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return loginpage();
          },
        ));
      });
    }
  }
}
