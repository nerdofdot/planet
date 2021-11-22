import 'package:flutter/material.dart';
import 'package:planet/views/accept_and_continue_button.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:planet/widgets/location_widget_page1_extended.dart';

class PlantATreePage extends StatelessWidget {

  DateTime dateToday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 0,right: 0,top: 0),
          child: Text("Great initiative!",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
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
                child: Text("Thanks for showing interest in saving the planet. We will forward the request.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30,right: 30,top: 10),
                child: TextButton.icon(
                  icon: Icon(Icons.mail_outline_rounded,color: Colors.green[600],size: 20,),
                  label: Text(completeInfo['email'].toString(),style: TextStyle(color: Colors.green[800],fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
                  onPressed: null,

                ),
              ),


              //from WIDGETS
              LocationWidgetPage1Extended(),

              //LocationWidgetPage1Extended(),

              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                child: Text("A tree for you!",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                child: Text("The NGO/organization will send you a picture of a tree they planted. The details are being shared with them to attain trust.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30,bottom: 20),
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),
                    child: ClipRRect(child: Image.asset("assets/images/treeImage.png",height: 280,),borderRadius: BorderRadius.circular(500),),
                  ),
                ),
              ),


              //from views
              AcceptAndContinueButton(),
            ],
          ),
        ),
      ),
    );
  }
}


