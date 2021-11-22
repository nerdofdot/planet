import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorPageMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/animations/errorAnimation.json",height: 300),
            Text("Ops! An error occurred!\nCheck your internet or restart.",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),)
          ],
        ),
      ),
    );
  }
}
