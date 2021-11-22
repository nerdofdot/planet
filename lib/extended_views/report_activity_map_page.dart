import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:planet/backend_firebase/location_service.dart';
import 'package:planet/flow_pages/loading_page.dart';

class GoogleMapLocationPage extends StatefulWidget {
  const GoogleMapLocationPage({Key? key}) : super(key: key);

  @override
  _GoogleMapLocationPageState createState() => _GoogleMapLocationPageState();
}

class _GoogleMapLocationPageState extends State<GoogleMapLocationPage> {

  Completer<GoogleMapController> _controller = Completer();

  Location location = new Location();
  LocationService locationService = LocationService();
  bool _serviceEnabled = false;
  late LocationData _locationData;
  bool isLocationEnabled = false;




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
      _serviceEnabled = await location.serviceEnabled();
      if(_serviceEnabled)
      {
        await getLocation();
        setLocationOverall(locationReceived);
        completeInfo['isLocationEnabled']=true;
        isLocationEnabled= true;
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
          isLocationEnabled= true;
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

  callfuture()async
  {
    locationReceived = await getLocationOfUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callfuture();
    completeInfo["location_of_report"] = GeoPoint(completeInfo['location_lat'], completeInfo["location_long"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 0,right: 0,top: 0),
          child: Text("Where did you see it?",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 0,bottom: 20),
              child: Text("Set location of the report. Be accurate while setting it. You can zoom in or out.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height/2,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(completeInfo["location_lat"],completeInfo["location_long"]),
                            zoom: 16,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          zoomControlsEnabled: false,
                          onCameraMove: (position)
                          {
                            LatLng currentLatLong = position.target;
                            print(currentLatLong);
                            completeInfo["location_of_report"] = GeoPoint(currentLatLong.latitude,currentLatLong.longitude);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Icon(Icons.circle_outlined,size: 40,color: Colors.black,)
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 20,bottom: 20),
              child: Text("Place exact location in the circle. Zooming in is preferable.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
            ),

            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width-70,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                  ),
                  icon: Icon(Icons.arrow_forward_rounded,color: Colors.white,),
                  label: Text("Continue",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/reportactivityfinal",);
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
