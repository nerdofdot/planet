import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class NurseryInCityView extends StatelessWidget {
  const NurseryInCityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30,right: 30,top: 30),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Colors.grey[100],
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        ColorizeAnimatedText("Papaya Nursery", textStyle: TextStyle(fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 21), colors: [Colors.black,Colors.grey,]),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text("Trambakeshwar Rd, near kuber petrolum, Nashik, Maharashtra 422012",style: TextStyle(fontFamily: "Lato",color: Colors.grey[600]),maxLines: 3,),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          //width: MediaQuery.of(context).size.width-280,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.phone,color: Colors.white,),
                            label: Text("Call      ",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 16),),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.green[500]),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                alignment: Alignment.centerLeft
                            ), onPressed: () {  },
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          height: 50,
                          //width: MediaQuery.of(context).size.width-280,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.location_on_rounded,color: Colors.white,),
                            label: Text("Location",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 16),),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.black54),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                alignment: Alignment.centerLeft
                            ), onPressed: () {  },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text("dotdevelopingteam has no affiliation with them.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
