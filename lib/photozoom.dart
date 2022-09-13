import 'package:flutter/material.dart';
import 'package:loginpage/thirdpage.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class photozoom extends StatefulWidget {

  List<Details> vi;
  int index;
  int index1;
  photozoom(this.vi, this.index, this.index1);


  @override
  State<photozoom> createState() => _photozoomState();
}

class _photozoomState extends State<photozoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PinchZoom(
        child:  Image.network(
            "https://shrey12.000webhostapp.com/demoapi/${widget.vi![widget.index].image!.split(",")[widget.index1]}"),
      ),
    );
  }
}
