import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planet/flow_pages/loading_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;


  Future initializeUser() async
  {
    await Firebase.initializeApp();
    final User? firebaseUser = await FirebaseAuth.instance.currentUser;
    await firebaseUser!.reload();
    _user = await _auth.currentUser;
  }

  navigateUser() async
  {
    // checking whether user already loggedIn or not
    if (_auth.currentUser != null)
    {
      // &&  FirebaseAuth.instance.currentUser.reload() != null
      Timer(Duration(milliseconds: 300),
            () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoadingSplashScreen(),),
                (Route<dynamic> route) => false),
        //if user is available go to home screen
      );
    }
    else
    {
      //if user is NOT  available go to Authentication of new user screen
      Timer(Duration(milliseconds: 300),
              () => Navigator.pushReplacementNamed(context, "/signuppage"));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeUser();
    navigateUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(child: Image.asset('assets/images/logo.png',height: 200,),borderRadius: BorderRadius.circular(30),),
                  Opacity(child: Text("planet",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Lato",fontSize: 30),),opacity: 0.6,)
                ],
              )
          ),
        ),
      ),
    );
  }
}
