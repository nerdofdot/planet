import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportActivityPage extends StatefulWidget {
  const ReportActivityPage({Key? key}) : super(key: key);

  @override
  _ReportActivityPageState createState() => _ReportActivityPageState();
}



class _ReportActivityPageState extends State<ReportActivityPage> {



  final _picker = ImagePicker();
  bool imageSelected = false;
  File? _image;


  permanentelyDeniedHandler(String mssg)async
  {
    showInSnackBar(mssg);
    await Future.delayed(Duration(milliseconds: 1600));
    AppSettings.openAppSettings();
  }

  Future getImageFromCamera() async {
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
        PickedFile? image = await _picker.getImage(source: ImageSource.camera,imageQuality: 13,preferredCameraDevice: CameraDevice.rear,).then((value){
          if(value == null)
          {
            print("tttttttttttttttt-----------------------------------------*****************###############");
            setState(() {
              imageSelected = false;
            });
          }
          else
          {
            print("#############################%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
            imageSelected = true;
            setState(() {
              File newFile = File(value.path);
              _image = newFile;
              completeInfo['imageFile'] = newFile;
            });
          }
        });
      }

  }


  Future getImageFromGallery()async{
    bool isGalleryGranted = false;
    var status = await Permission.storage.status;

    if(status.isDenied)
    {
      await Permission.camera.request().then((value) => {
        if(value == PermissionStatus.granted)
          {
            isGalleryGranted = true
          }
        else if(value == PermissionStatus.permanentlyDenied)
          {
            permanentelyDeniedHandler("Gallery permission denied. Enable it.")
          }
      });
    }
    else if(status.isGranted)
    {
      isGalleryGranted = true;
    }

    if(isGalleryGranted)
      {
        PickedFile? image = await _picker.getImage(source: ImageSource.gallery,imageQuality: 9,preferredCameraDevice: CameraDevice.rear).then((value){
          if(value == null)
          {
            print("tttttttttttttttt-----------------------------------------*****************###############");
            setState(() {
              imageSelected = false;
            });
          }
          else
          {
            print("#############################%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
            imageSelected = true;
            setState(() {
              File newFile = File(value.path);
              _image = newFile;
              completeInfo['imageFile'] = newFile;
            });
          }
        });
      }

  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value)
  {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content:Row(
      children: [
        Icon(Icons.error_outline_rounded,color: Colors.white,),
        Text("   "+value),
      ],
    ),
      backgroundColor: Colors.black87,
      duration: Duration(milliseconds: 1500),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 0,right: 0,top: 0),
          child: Text("You're a saviour!",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 0),
                child: Text("You are generating a report for our planet. The data is shared with governments/organization, so be cautious.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height/2.2,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: imageSelected?ClipRRect(child: Image.file(_image!,fit: BoxFit.cover,),borderRadius: BorderRadius.circular(30),):Center(child: Text("Click/Select an image",style: TextStyle(fontFamily: "Lato"),),),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25,right: 25,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 50,
                      width: (MediaQuery.of(context).size.width-70)/2.2,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                        ),
                        icon: Icon(Icons.camera_alt_rounded,color: Colors.black87,),
                        label: Text("Camera",style: TextStyle(color: Colors.black87,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
                        onPressed: () {
                            getImageFromCamera();
                        },
                      ),
                    ),

                    Container(
                      height: 50,
                      width: (MediaQuery.of(context).size.width-70)/2.2,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                        ),
                        icon: Icon(Icons.insert_photo,color: Colors.black87,),
                        label: Text("Gallery",style: TextStyle(color: Colors.black87,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
                        onPressed: () {
                          getImageFromGallery();
                        },
                      ),
                    ),
                  ],
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                child: Text("*Posting of any vulgar or non related picture may land you in trouble.",style: TextStyle(color: Colors.red[200],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
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
                    icon: Icon(Icons.arrow_forward_rounded,color: Colors.white,),
                    label: Text("Continue",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
                    onPressed: () {
                      if(imageSelected)
                        {
                          Navigator.pushReplacementNamed(context, "/reportactivitymap",);
                        }
                      else
                        {
                         showInSnackBar("Please provide an image");
                        }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
