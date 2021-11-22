import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:planet/backend_firebase/location_service.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:planet/views/recent_report_view_page2.dart';
import 'package:planet/views/report_tree_cut_view_page2.dart';

class ZweiPage extends StatefulWidget {
  const ZweiPage({Key? key}) : super(key: key);

  @override
  _ZweiPageState createState() => _ZweiPageState();
}

class _ZweiPageState extends State<ZweiPage> {

  Location location = new Location();
  LocationService locationService = LocationService();
  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;



  Map<String,dynamic> locationReceived =
  {
    "country": null,
    "city": null,
    "location_lat": null,
    "location_long": null,
  };


  setLocationOverall(Map<String,dynamic> mapSet)
  {
    completeInfo['country'] = mapSet['country'];
    completeInfo['city'] = mapSet['city'];
    completeInfo['location_lat'] = mapSet['location_lat'];
    completeInfo['location_long']= mapSet['location_long'];
  }

  getLocation()async
  {
    _locationData = await location.getLocation();
    locationReceived = await locationService.getAddressFromLatLng(_locationData);
    print("+++++++++++++++++++++++++++++++++++++++");
    print(locationReceived);
    return locationReceived;
  }

  Future<Map<String,dynamic>> getLocationOfUser() async
  {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied||_permissionGranted == PermissionStatus.deniedForever)
    {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.denied|| _permissionGranted == PermissionStatus.deniedForever)
      {
        print(locationReceived);
        return locationReceived;
      }
      else
      {
        _serviceEnabled = await location.serviceEnabled();
        if(_serviceEnabled)
        {
          await getLocation();
          setLocationOverall(locationReceived);
          completeInfo['isLocationEnabled']=true;
          return locationReceived;
        }
        else
        {
          _serviceEnabled = await location.requestService();
          if(_serviceEnabled)
          {
            await getLocation();
            setLocationOverall(locationReceived);
            completeInfo['isLocationEnabled']=true;
            return locationReceived;
          }
          else{
            print(locationReceived);
            return locationReceived;
          }
        }
      }
    }
    else
    {
      print("here1");
      _serviceEnabled = await location.serviceEnabled();
      if(_serviceEnabled)
      {
        await getLocation();
        setLocationOverall(locationReceived);
        completeInfo['isLocationEnabled']=true;
        return locationReceived;
      }
      else
      {
        print("here2");
        _serviceEnabled = await location.requestService();
        if(_serviceEnabled)
        {
          print("here666");
          await getLocation();
          setLocationOverall(locationReceived);
          completeInfo['isLocationEnabled']=true;
          print(locationReceived);
          return locationReceived;
        }
        else
        {
          print("here3");
          print(locationReceived);
          return locationReceived;
        }
      }
    }
  }

  callfuture()async
  {
    locationReceived = await getLocationOfUser();
  }

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    if(completeInfo["city"]==null||completeInfo["city"]=='unknown')
    {
      callfuture();
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 35,right: 35,top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Report ",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
                          AnimatedTextKit(
                            pause: Duration(milliseconds: 700),
                            repeatForever: true,
                            animatedTexts: [
                              TyperAnimatedText("tree chop down",textStyle: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
                              TyperAnimatedText("polluted water",textStyle: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
                              TyperAnimatedText("garbage",textStyle: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
                              TyperAnimatedText("polluted air",textStyle: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
                              TyperAnimatedText("animal abuse",textStyle: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
                            ],
                          )
                        ],
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                      child: Text("If you see any nature harming activity, just report! Your few seconds can save earth.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),

                    ),
                  ],
                ),
                ReportTreeCutView(),
              ],
            ),


            RecentReportView(),

          ],
        ),
      ),
    );
  }
}
