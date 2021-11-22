import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/backend_firebase/location_service.dart';
import 'package:planet/flow_pages/loading_page.dart';

import 'package:planet/views/news_view_page1.dart';
import 'package:planet/views/tree_planting_request_view_page1.dart';
import 'package:planet/views/trees_cut_view_page1.dart';

import 'package:app_settings/app_settings.dart';


class EinsPage extends StatefulWidget {
  const EinsPage({Key? key}) : super(key: key);

  @override
  _EinsPageState createState() => _EinsPageState();
}

class _EinsPageState extends State<EinsPage> {

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
    callfuture();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Lottie.asset("assets/animations/boyinparkAnimation.json",height:410),
                        ),
                      ),

                      //News View from VIEWS
                      NewsView(),
                    ],
                  ),

                  //Tree cut view from VIEWS
                  TreesCutView(),
                ],
              ),
            ),

            //tree planting req view from VIEWS
            TreePlantingRequestView(),

            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 20),
              child: Text("The associated NGOs are working on your plantation requests.",style: TextStyle(color: Colors.grey[400],fontFamily: "Lato",fontWeight: FontWeight.w400,fontSize: 14),),
            ),
          ],
        ),
      ),
    );
  }
}


