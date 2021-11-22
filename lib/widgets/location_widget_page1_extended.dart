import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:planet/backend_firebase/location_service.dart';
import 'package:planet/flow_pages/loading_page.dart';

class LocationWidgetPage1Extended extends StatefulWidget {

  @override
  _LocationWidgetPage1ExtendedState createState() => _LocationWidgetPage1ExtendedState();
}

class _LocationWidgetPage1ExtendedState extends State<LocationWidgetPage1Extended> {

  bool locationAvailable = false;
  checkLocationData()
  {
    if(completeInfo['city']==null&&completeInfo['country']==null||completeInfo['city']=='unknown'&&completeInfo['country']=='Unknown')
      {
        locationAvailable = false;
      }
    else
      {
        locationAvailable = true;
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left: 30,right: 30,top: 0),
      child: locationAvailable?TextButton.icon(
        icon: Icon(Icons.location_searching_rounded,color: Colors.grey[600],size: 20,),
        label: Text(completeInfo['city'].toString().toUpperCase()+", "+completeInfo['country'].toString().toUpperCase(),style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
        onPressed: null,
      ):TextButton.icon(
        icon: Icon(Icons.location_off_rounded,color: Colors.grey[600],size: 20,),
        label: Text("Tap to enable location  ",style: TextStyle(color: Colors.grey[700],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 16),),
        onPressed: () async {
          AppSettings.openLocationSettings().whenComplete(() => Navigator.of(context).pop());
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.grey[200])
        ),
      ),
    );
  }
}
