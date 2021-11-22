import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/backend_firebase/getter_database.dart';
import 'package:planet/flow_pages/home_page.dart';
import 'package:planet/views/signup_button_view.dart';



class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin{

  late AnimationController animationController;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));

  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    animationController.repeat(period: Duration(milliseconds: 2500));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 40),
                child: Text("Hey you!\nYessss you!",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
              ),
              Center(
                  child: Lottie.asset("assets/animations/monkeyAnimation.json",height: 350,width: 350,reverse: true)
              ),

              Padding(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Remember me?",style: TextStyle(color: Colors.grey,fontFamily: "Lato",fontSize: 30,fontWeight: FontWeight.w700),),
                    Text("I am ",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontSize: 41,fontWeight: FontWeight.w700),),
                    AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText("Alex",textStyle: TextStyle(color: HexColor("#dac4ff"),fontFamily: "Lato",fontSize: 75,fontWeight: FontWeight.w700,),),
                        TyperAnimatedText("Chuck",textStyle: TextStyle(color: HexColor("#dac4ff"),fontFamily: "Lato",fontSize: 75,fontWeight: FontWeight.w700,),),
                        TyperAnimatedText("Tim",textStyle: TextStyle(color: HexColor("#dac4ff"),fontFamily: "Lato",fontSize: 75,fontWeight: FontWeight.w700,),),
                        TyperAnimatedText("Jack",textStyle: TextStyle(color: HexColor("#dac4ff"),fontFamily: "Lato",fontSize: 75,fontWeight: FontWeight.w700,),),
                        TyperAnimatedText("Bing",textStyle: TextStyle(color: HexColor("#dac4ff"),fontFamily: "Lato",fontSize: 75,fontWeight: FontWeight.w700,),),
                        TyperAnimatedText("Luke",textStyle: TextStyle(color: HexColor("#dac4ff"),fontFamily: "Lato",fontSize: 75,fontWeight: FontWeight.w700,),),
                      ],
                    ),
                  ],
                ),
              ),


              ColorFiltered(child: Lottie.asset("assets/animations/scrolldownAnimation.json",height: 150,width: 150),
                colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcATop),),


              Padding(
                padding: EdgeInsets.only(left: 30,top: 500),
                child: Text("You!",style: TextStyle(color: Colors.grey[400],fontFamily: "Lato",fontSize: 120,fontWeight: FontWeight.w700),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TyperAnimatedText("Humans",textStyle: TextStyle(color: Colors.grey[700],fontFamily: "Lato",fontSize: 60,fontWeight: FontWeight.w700,),),
                    TyperAnimatedText("Idiots",textStyle: TextStyle(color: Colors.grey[700],fontFamily: "Lato",fontSize: 60,fontWeight: FontWeight.w700,),),
                    TyperAnimatedText("Selfish",textStyle: TextStyle(color: Colors.grey[700],fontFamily: "Lato",fontSize: 60,fontWeight: FontWeight.w700,),),
                    TyperAnimatedText("Maniacs",textStyle: TextStyle(color: Colors.grey[700],fontFamily: "Lato",fontSize: 60,fontWeight: FontWeight.w700,),),
                    TyperAnimatedText("Careless",textStyle: TextStyle(color: Colors.grey[700],fontFamily: "Lato",fontSize: 60,fontWeight: FontWeight.w700,),),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30,top:20),
                child: Text("I had a sweet home",style: TextStyle(color: Colors.grey,fontFamily: "Lato",fontSize: 30,fontWeight: FontWeight.w700),),
              ),
              LottieBuilder.asset("assets/animations/treeAnimation.json",repeat: false,),
              Padding(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Text("Why did you cut it?",style: TextStyle(color: Colors.grey,fontFamily: "Lato",fontSize: 30,fontWeight: FontWeight.w700),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30,right: 30,top: 30),
                child: Text("To make your",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontSize: 30,fontWeight: FontWeight.w700),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Text("Couch!",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontSize: 60,fontWeight: FontWeight.w700),),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 170),
                child: ColorFiltered(child: Lottie.asset("assets/animations/scrolldownAnimation.json",height: 150,width: 150),
                  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcATop),),
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 30,top:50),
                    child: Text("Even BIRDY has the similar complaint!",style: TextStyle(color: Colors.grey,fontFamily: "Lato",fontSize: 30,fontWeight: FontWeight.w700),),
                  ),
                  Lottie.asset("assets/animations/birdAnimation.json",controller: animationController)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 30,right: 30,top: 30),
                child: Text("Now",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontSize: 70,fontWeight: FontWeight.w700),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30,right: 30,bottom: 60),
                child: Text("Fix it!",style: TextStyle(color: Colors.black,fontFamily: "Lato",fontSize: 70,fontWeight: FontWeight.w700),),
              ),

              ColorFiltered(child: Lottie.asset("assets/animations/scrolldownAnimation.json",height: 150,width: 150),
                colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcATop),),

              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 260),
                child: Text("Plant a tree",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 0,bottom: 0),
                child: Text("and",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
              ),

              //from views

              SignupButton(),

            ],
          ),
        ),
      ),
    );
  }
}

