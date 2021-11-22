import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:planet/views/plant_info_card_view_extended.dart';
import 'package:planet/views/plants_name_view_extended.dart';

class PlantInfoPage extends StatefulWidget {
  const PlantInfoPage({Key? key}) : super(key: key);

  @override
  _PlantInfoPageState createState() => _PlantInfoPageState();
}

class _PlantInfoPageState extends State<PlantInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 0,right: 0,top: 0),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ColorizeAnimatedText(completeInfo["nameOfNursery"], textStyle: TextStyle(fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),colors: [Colors.black,Colors.grey]),
            ],
          ),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 0),
                child: Text("See the details a buy your plant",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
              ),

              PlantNameView(),

              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 0),
                child: Text("The info below is specified by "+completeInfo["nameOfNursery"]+". The prices may vary based on the present condition. Please contact the person in nursery to know more.\n\napp by dotdevelopingteam\n\n",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
              ),

              PlantInfoCardView(),
            ],
          ),
        ),
      ),
    );
  }
}
