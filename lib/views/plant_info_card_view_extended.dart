import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/flow_pages/loading_page.dart';

class PlantInfoCardView extends StatelessWidget {
  const PlantInfoCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          child: Card(
            color: Colors.black87,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 35,right: 35,top: 30),
                  child: Text("Type:",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 20),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35,right: 35,top: 0),
                  child: Text(completeInfo['typeOfPlant'].toString(),style: TextStyle(color: Colors.grey[300],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                  child: Text("Price:",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 20),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35,right: 35,top: 0),
                  child: Text("₹ "+completeInfo['price'].toString(),style: TextStyle(color: Colors.grey[300],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                  child: Text("Temp:",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 20),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35,right: 35,top: 0),
                  child: Text(completeInfo['minTemp'].toString()+"°c - "+completeInfo['maxTemp'].toString()+"°c",style: TextStyle(color: Colors.grey[300],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                  child: Text("Requirements:",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 20),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35,right: 35,top: 10),
                  child: Row(
                    children: [
                      completeInfo['isSunNeeded']?ColorFiltered(child: Image.asset("assets/images/sun.png",height: 35,width: 35,),colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcATop),):Container(),
                      SizedBox(width: 10,),
                      completeInfo['isWaterNeeded']?ColorFiltered(child: Image.asset("assets/images/drops.png",height: 30,width: 30,),colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcATop),):Container(),
                      SizedBox(width: 10,),
                      completeInfo['isChemicalNeeded']?ColorFiltered(child: Image.asset("assets/images/flask.png",height: 30,width: 30,),colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcATop),):Container(),

                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                  child: Text("Care needed:",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 20),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35,right: 35,top: 0,bottom: 30),
                  child: Text(completeInfo['care'].toString(),style: TextStyle(color: Colors.grey[300],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
                ),
              ],
            ),
          ),
        ),
        Opacity(child: Lottie.asset("assets/animations/plantpotAnimation.json",height: 310,repeat: true,reverse: true),opacity: 0.8,)
      ],
    );
  }
}
