import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';




class PlantQRScannerView extends StatefulWidget {
  const PlantQRScannerView({Key? key}) : super(key: key);

  @override
  _PlantQRScannerViewState createState() => _PlantQRScannerViewState();
}

class _PlantQRScannerViewState extends State<PlantQRScannerView> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late int visitedAnimation;
  List<String> urls = ["plant1.json","plant2.json","plant3.json","plant4.json"];

  permanentelyDeniedHandler(String mssg)async
  {
    showToast(context,mssg);
    await Future.delayed(Duration(milliseconds: 1600));
    AppSettings.openAppSettings();
  }

  void showToast(BuildContext context,String value,) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
          backgroundColor: Colors.black,
          duration: Duration(milliseconds: 1500),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    //playPlantAnimation();
    visitedAnimation=0;
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 3000),animationBehavior: AnimationBehavior.normal);
  }

  @override
  void dispose(){
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  growTheAnimation()
  {
    visitedAnimation++;
    _animationController.reset();
    _animationController.forward();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){
            growTheAnimation();
          },
          child: Center(
            child: Lottie.asset("assets/animations/"+urls[visitedAnimation%4],height: 300,reverse: true),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 35,right: 35,top: 40),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width-70,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
              ),
              icon: Icon(Icons.qr_code_2_rounded,color: Colors.white,),
              label: Text("Tap to scan",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
              onPressed: () async{
                bool isCameraGranted = false;
                var status = await Permission.camera.status;
                if(status.isDenied)
                {
                  await Permission.camera.request().then((value) => {
                    if(value == PermissionStatus.granted)
                      {
                        isCameraGranted = true
                      }
                    else if(value == PermissionStatus.permanentlyDenied)
                      {
                        permanentelyDeniedHandler("Camera permission denied. Enable it.")
                      }
                  });
                }
                else if(status.isGranted)
                {
                  isCameraGranted = true;
                }


                if(isCameraGranted)
                  {
                    Navigator.pushNamed(context, "/toQR");
                  }

              },

            ),
          ),
        ),
      ],
    );
  }
}



