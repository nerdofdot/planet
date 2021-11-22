import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:planet/backend_firebase/setter_database.dart';
import 'package:planet/extended_views/plant_a_tree_page.dart';
import 'package:planet/flow_pages/loading_page.dart';

bool isDone = false;

class AcceptAndContinueButton extends StatefulWidget {
  const AcceptAndContinueButton({Key? key}) : super(key: key);

  @override
  _AcceptAndContinueButtonState createState() => _AcceptAndContinueButtonState();
}

class _AcceptAndContinueButtonState extends State<AcceptAndContinueButton> {

  bool requestStatus = false;
  SetData setData = SetData();
  DateTime dayToday = DateTime.now();

  void showToast(BuildContext context,String value,bool isDone) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 1),
        content: Row(
          children: [
            Icon(isDone?Icons.check:Icons.error_outline,color: Colors.white,),
            Text(value,style: TextStyle(color: Colors.white,fontFamily: "Lato"),)
          ],
        )
      ),
    );
  }

  bool locationAvailable = false;
  checkLocationData()
  {
    if(completeInfo['city']==null&&completeInfo['country']==null)
    {
      locationAvailable = false;
      completeInfo['country'] = "Unknown";
      completeInfo['city'] = "unknown";
      completeInfo['location_lat'] = 0.1;
      completeInfo['location_long'] = 0.1;
    }
    else
    {
      locationAvailable = true;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 35,right: 35,top: 20),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width-70,
        child: ElevatedButton(
          autofocus: false,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              requestStatus?Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,),height: 20,width: 20,),
              ):Container(),
              Text("Accept & continue",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
            ],
          ),
          onPressed: () async {
                setState(() {
                  requestStatus = true;
                });
                checkLocationData();
                Map<String,dynamic> requestMap = {
                  "email":"nsnsns",
                  "location":GeoPoint(completeInfo['location_lat'],completeInfo['location_long']),
                  "date": dayToday,
                  "city":completeInfo['city'],
                };

                isDone = await setData.setDPlantingRequest(completeInfo['country'], "request", requestMap);

                if(isDone)
                {
                  setState(() {
                    requestStatus = false;
                  });

                  this.showToast(context,"  Request sent successfully",isDone);
                  await Future.delayed(Duration(seconds: 1));
                  completeInfo["no_of_requests"]++;
                  Navigator.pop(context);
                }
                else
                {
                  this.showToast(context,"  An error occurred",isDone);
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pop(context);
                }
          },
        ),
      ),
    );
  }
}
