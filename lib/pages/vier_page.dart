import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/views/plant_qr_scanner_view_page4.dart';


class VierPage extends StatefulWidget {
  const VierPage({Key? key}) : super(key: key);

  @override
  _VierPageState createState() => _VierPageState();
}

class _VierPageState extends State<VierPage>{


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 40),
              child: Text("Visiting a nursery?",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 20),
              child: Text("Visit a nursery and if we are affiliated with them, there plants must have a QR code! Scan to know more about the plant.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 30),
              child: Text("Tap on the plant to grow it",style: TextStyle(color: Colors.grey[400],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 18),),
            ),

            //from Views
            PlantQRScannerView(),

            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 40),
              child: Text("Make your nursery\nfuturistic.",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 0),
              child: Text("Contact dotdevelopingteam\nnow!",style: TextStyle(color: Colors.grey[400],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
            ),

          ],
        ),
      ),
    );
  }
}

