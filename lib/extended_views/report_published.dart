import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReportPublishedPage extends StatelessWidget {
  const ReportPublishedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 0,right: 0,top: 0),
          child: Text("Thanks for reporting",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
        ),
        elevation: 0,
        toolbarHeight: 75,
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(
            size: 100
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Center(child: Lottie.asset("assets/animations/finalAnimation.json",height: 300)),
            Padding(
              padding: const EdgeInsets.all(35),
              child: Text("Now there is no need of going to Mars or Moon. You made Earth slightly better!",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Lato",color: Colors.grey[400],fontSize: 17),),
            )
          ],
        ),
      ),
    );
  }
}
