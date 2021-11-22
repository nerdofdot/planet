import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:planet/backend_firebase/check_internet_connection.dart';
import 'package:planet/backend_firebase/location_service.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:planet/views/accept_and_continue_button.dart';
class TreePlantingRequestView extends StatefulWidget {
  const TreePlantingRequestView({Key? key}) : super(key: key);

  @override
  _TreePlantingRequestViewState createState() => _TreePlantingRequestViewState();
}

class _TreePlantingRequestViewState extends State<TreePlantingRequestView> {

  CheckInternet checkInternet = CheckInternet();

  void showToast(BuildContext context,String value) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
          backgroundColor: Colors.black,
          duration: Duration(seconds: 1),
          content: Row(
            children: [
              Icon(Icons.not_interested_rounded,color: Colors.white,),
              Text(value,style: TextStyle(color: Colors.white,fontFamily: "Lato"),)
            ],
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 35,right: 35,top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tree planting requests till date:",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 16),),
          Opacity(child: Text(completeInfo["no_of_requests"].toString(),style: TextStyle(color: Colors.grey[700],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 50),),opacity:0.5,),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text("We will plant a tree for you and send you a picture via e-mail. Just give us your details!",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 14),),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width-70,
              child: TextButton.icon(
                icon: Icon(Icons.add,color: Colors.white,),
                label: Text("Plant a tree",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                ),
                onPressed: ()async {
                  print(completeInfo);
                  bool isInternetAvailable = await checkInternet.isIntenetAvailable();
                  if(isInternetAvailable)
                    {
                      Navigator.pushNamed(context, "/plantatree").whenComplete((){
                        setState(() {

                        });
                      });
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
