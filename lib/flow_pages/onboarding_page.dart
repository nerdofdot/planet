import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:planet/backend_firebase/setter_database.dart';
import 'package:planet/flow_pages/home_page.dart';
import 'package:planet/flow_pages/loading_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  final introKey = GlobalKey<IntroductionScreenState>();

  List<Color> colorList = [HexColor("#171717"),Colors.redAccent,Colors.orangeAccent,Colors.greenAccent];
  int currentIndex = 0;
  SetData setData = SetData();
  bool isDone = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value)
  {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content:Row(
      children: [
        Icon(Icons.info_rounded,color: Colors.black54,),
        Text("   "+value,style: TextStyle(color: Colors.black54),),
      ],
    ),
      backgroundColor: Colors.white,
      duration: Duration(milliseconds: 1000),
    ));
  }

  void _onIntroEnd(context) async{
    print("end");
    showInSnackBar("Setting up user");
    if(isDone)
      {

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => LoadingSplashScreen()),
                (Route<dynamic> route) => false);
      }
    else
      {
        showInSnackBar("Error occurred. Try again");
      }

  }

  setUserUp()async
  {
    print("hhhhhhhhh");
    isDone = await setData.setNewUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserUp();
  }

  @override
  Widget build(BuildContext context) {

    var pageDecoration =  PageDecoration(
      titleTextStyle: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Lato",),
      bodyTextStyle: TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.w300,fontFamily: "Lato"),
      descriptionPadding: EdgeInsets.fromLTRB(35, 20.0,35, 0),
      imagePadding: EdgeInsets.only(top: 0),
      pageColor: colorList[currentIndex],
    );

    return Scaffold(
      key: _scaffoldKey,
      body: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: colorList[currentIndex],
        color: Colors.white,
        pages: [
          PageViewModel(
            title: "Hey! welcome to planet",
            body:
            "We are glad that you installed the app and have shown concern for our planet. Cheers we would plant a tree for you!",
            image: Image.asset("assets/images/neptune.png",height: 200,),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Report nature harming events",
            body:
            "Now as you are the part of team planet, you just need to report noxious activities that harm nature. That is quite a easy task! So let\'s gooooooo.",
            image:  Image.asset("assets/images/complain.png",height: 200,),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Live updates and news",
            body:
            "Get live news, updates, facts that are shocking and completely interesting to pass on to people.",
            image:  Image.asset("assets/images/news-report.png",height: 200,),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Get info of plants in nursery",
            body:
            "Nurseries affiliated with us are futuristic. It\'s a surprise mate. Now lets meet again in the app!",
            image:  Image.asset("assets/images/plantimg.png",height: 200,),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        onChange: (index) async {
          print("int index");
          setState(() {
            currentIndex = index;
          });
        },
        curve: Curves.easeInSine,
        skip: const Text('Skip',),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Colors.white60,
          activeColor: Colors.white,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
