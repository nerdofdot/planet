import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/backend_firebase/check_internet_connection.dart';
import 'package:planet/backend_firebase/location_service.dart';
import 'package:planet/flow_pages/loading_page.dart';

class ReportTreeCutView extends StatefulWidget {
  const ReportTreeCutView({Key? key}) : super(key: key);

  @override
  _ReportTreeCutViewState createState() => _ReportTreeCutViewState();
}

class _ReportTreeCutViewState extends State<ReportTreeCutView> {

  CheckInternet checkInternet = CheckInternet();


  void showToast(BuildContext context,String value,) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
          backgroundColor: Colors.black,
          duration: Duration(seconds: 1),
          content: Row(
            children: [
              Icon(Icons.error_outline,color: Colors.white,),
              Text(value,style: TextStyle(color: Colors.white,fontFamily: "Lato"),)
            ],
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
              child: Lottie.asset("assets/animations/dayNightAnimation.json")
          ),
          Padding(
            padding: EdgeInsets.only(left: 35,right: 35,top: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width-70,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                ),
                icon: Icon(Icons.camera_alt_rounded,color: Colors.white,),
                label: Text("Tap to report",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
                onPressed: () async{
                  bool isInternetAvailable = await checkInternet.isIntenetAvailable();
                  if(isInternetAvailable)
                    {
                      if(completeInfo['isLocationEnabled'])
                      {
                        Navigator.pushNamed(context, "/reportactivity",);
                      }
                      else
                      {
                        showToast(context, "  The location permission should be granted");
                      }
                    }
                  else
                    {
                      showToast(context, "  No internet connection",);
                    }

                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
