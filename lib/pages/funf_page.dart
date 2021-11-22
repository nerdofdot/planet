import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:planet/views/donation_view_page5.dart';

class FunfPage extends StatefulWidget {
  const FunfPage({Key? key}) : super(key: key);

  @override
  _FunfPageState createState() => _FunfPageState();
}

class _FunfPageState extends State<FunfPage> {
  DateTime date = DateTime.now();
  bool isSongPlaying = false;

  bool visited = false;

  final assetsAudioPlayer = AssetsAudioPlayer();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String valu)
  {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content:Row(
      children: [
        Icon(Icons.play_arrow_rounded,color: Colors.green[700],),
        Text("   "+valu,style: TextStyle(fontFamily: "Lato",fontWeight: FontWeight.w700,color: Colors.green[700]),),
      ],
    ),
      backgroundColor: Colors.green[100],
      duration: Duration(milliseconds: 3500),
    ));
  }

  playTheSong()async
  {
    try {
      await assetsAudioPlayer.open(
        Audio.network("https://drive.google.com/uc?export=view&id=1rjPZMviUV5hby4gAZbvI25JtbEmye7h7",),
      );
      await assetsAudioPlayer.play();
    }
    catch (t)
    {
      //mp3 unreachable
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await assetsAudioPlayer.stop();
    await assetsAudioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 40),
                child: Text("About dotdevelopingteam",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                child: Text("We are start up working on ingenious products. This app is a leap towards saving the world. If we don't act we won't survive or our future generations are at stake!",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
              ),
              Center(
                child: Lottie.asset("assets/animations/planetAnimation.json",height:300),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 0),
                child: Text("It's ${date.hour}:${date.minute} now! Clock's ticking.",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 0),
                child: Text("So start counting years as",style: TextStyle(color: Colors.grey[400],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 0),
                child: Text("we don't love mars but",style: TextStyle(color: Colors.grey[700],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 0,bottom: 20),
                child: Text("our planet.",style: TextStyle(color: Colors.green[300],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
              ),


              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //from views
                  DonationButtonView(),


                  Padding(
                    padding: EdgeInsets.only(left: 15,top: 20,bottom: 0,right: 35),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          border: null,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),

                      child: IconButton(
                        icon: Icon(isSongPlaying?Icons.pause:Icons.play_arrow_rounded,color: Colors.white,size: 30,),
                        onPressed: (){
                          isSongPlaying = !isSongPlaying;
                          if(isSongPlaying)
                            {
                              if(visited == false)
                                {
                                  showInSnackBar("Playing....   Earth - Lil Dicky");
                                  playTheSong();
                                  visited = true;
                                }
                              else
                                {
                                  assetsAudioPlayer.play();
                                }
                            }
                          else
                            {
                              assetsAudioPlayer.pause();
                            }
                          setState(() {

                          });
                        },
                        highlightColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                child: Text("© PLANET developed by nerd",style: TextStyle(color: Colors.grey[700],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 15),),
              ),

              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 90,bottom: 0),
                child: Text("Thank you "+completeInfo["nameOfUser"],style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 20,bottom: 15),
                child: Text("You showed interest in saving the planet! That is appreciated. If 7 billion people start thinking the way you do.....that would transform the world!",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
              ),

              Center(child: Card(child: ClipRRect(child: Image.network(completeInfo['imageOfUser']),borderRadius: BorderRadius.circular(150),),elevation: 10,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(150)),)),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}

