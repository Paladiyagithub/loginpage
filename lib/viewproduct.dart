import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginpage/photozoom.dart';
import 'package:loginpage/sharep.dart';
import 'package:loginpage/thirdpage.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class vip extends StatefulWidget {
  List<Details>? vi;
  int index;

  vip(this.vi, this.index);

  @override
  State<vip> createState() => _vipState();
}

class _vipState extends State<vip> {
  static const platform = const MethodChannel("razorpay_flutter");


  List ve = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Easy Shopping"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Card(
                    color: Colors.black,
                    child: Container(
                      height: 400,
                      child: PageView.builder(
                        itemCount: widget.vi![widget.index].image!.split(",").length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.white54,
                            margin: EdgeInsets.only(top: 20),
                            // height: 200,
                            child: PinchZoom(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return photozoom(widget.vi!,widget.index,index);
                                  },));
                                },
                                child: Image.network(
                                    "https://shrey12.000webhostapp.com/demoapi/${widget.vi![widget.index].image!.split(",")[index]}"),
                              ),
                            ),
                          ); // return
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40,top: 20),
                        child: Text("M.R.P. :",style: TextStyle(color: Colors.white54,fontSize: 20),),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15,top: 20),
                        child: Text("₹${widget.vi![widget.index].oldprice}.00",style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.white54,fontSize: 20),),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10,top: 5),
                        child: Text("Deal Price : ",style: TextStyle(color: Colors.white54,fontSize: 20)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5,top: 5),
                        child: Text("₹${widget.vi![widget.index].currentprice}.00",style: TextStyle(color: Colors.white54,fontSize: 25),),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20,left: 20),
                        child: Text("Description :-  ",style: TextStyle(fontSize: 18,color: Colors.white54),),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(onPressed: openCheckout, child: Text("Pay")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String? nu;
  String? em;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    nu = share.sp!.getString("number") ?? "";
    em = share.sp!.getString("number") ?? "";
  }
  late Razorpay _razorpay;
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_ElgYE7POck0qRm',
      'amount': double.parse(widget.vi![widget.index].currentprice!) * 100,
      'name': '${widget.vi![widget.index].productname}',
      // 'description': '${widget.vi![widget.index].description}',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '${nu}', 'email': '${em}'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

}
