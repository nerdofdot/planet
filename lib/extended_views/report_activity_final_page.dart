

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/backend_firebase/setter_database.dart';
import 'package:planet/flow_pages/loading_page.dart';


class ReportActivityFinalPage extends StatefulWidget {
  const ReportActivityFinalPage({Key? key}) : super(key: key);

  @override
  _ReportActivityFinalPageState createState() => _ReportActivityFinalPageState();
}

class _ReportActivityFinalPageState extends State<ReportActivityFinalPage> {
  bool tree_chopped = true;
  bool water =false;
  bool air = false;
  bool animal = false;
  bool garbage = false;
  String reportDescription = " ";
  String type = "tree";

  bool isReportPublished = false;

  SetData setData = SetData();

  bool isComplete= false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String valu,bool complete)
  {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content:Row(
      children: [
        Icon(complete?Icons.check:Icons.error_outline_rounded,color: Colors.white,),
        Text("   "+valu),
      ],
    ),
      backgroundColor: Colors.black87,
      duration: Duration(milliseconds: 2500),
    ));
  }

  void showInSnackBar2(String valu,bool complete)
  {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content:Row(
      children: [
        Icon(Icons.info_outline_rounded,color: Colors.grey[800],),
        Text("   "+valu,style: TextStyle(color: Colors.grey[700]),),
      ],
    ),
      backgroundColor: Colors.grey[200],
      duration: Duration(milliseconds: 2500),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 0,right: 0,top: 0),
          child: Text("Describe it",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 35,right: 35,top: 0,bottom: 20),
                child: Text("Just a step. Select a category and describe the event.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile(
                      value: tree_chopped,
                      groupValue: true,
                      title: Text("Tree chopped",style: TextStyle(fontFamily: "Lato",fontWeight: FontWeight.w600,color: Colors.grey[800]),),
                      onChanged: (val){
                        tree_chopped = true;
                        water =false;
                        air = false;
                        animal = false;
                        garbage = false;
                        type = "tree";
                        setState(() {

                        });
                      },
                      activeColor: Colors.red[900],
                    ),
                    RadioListTile(
                      value: water,
                      groupValue: true,
                      title: Text("Water polluted",style: TextStyle(fontFamily: "Lato",fontWeight: FontWeight.w600,color: Colors.grey[800])),
                      onChanged: (val){
                        tree_chopped = false;
                        water =true;
                        air = false;
                        animal = false;
                        garbage = false;
                        type="water";
                        setState(() {

                        });
                      },
                      activeColor: Colors.red[900],
                    ),
                    RadioListTile(
                      value: air,
                      groupValue: true,
                      title: Text("Air polluted",style: TextStyle(fontFamily: "Lato",fontWeight: FontWeight.w600,color: Colors.grey[800])),
                      onChanged: (val){

                        tree_chopped = false;
                        water =false;
                        air = true;
                        animal = false;
                        garbage = false;
                        type="air";
                        setState(() {

                        });
                      },
                      activeColor: Colors.red[900],
                    ),
                    RadioListTile(
                      value: garbage,
                      groupValue: true,
                      title: Text("Garbage",style: TextStyle(fontFamily: "Lato",fontWeight: FontWeight.w600,color: Colors.grey[800])),
                      onChanged: (val){

                        tree_chopped = false;
                        water =false;
                        air = false;
                        animal = false;
                        garbage = true;
                        type="garbage";
                        setState(() {

                        });
                      },
                      activeColor: Colors.red[900],
                    ),
                    RadioListTile(
                      value: animal,
                      groupValue: true,
                      title: Text("Animal abuse",style: TextStyle(fontFamily: "Lato",fontWeight: FontWeight.w600,color: Colors.grey[800])),
                      onChanged: (val){

                        tree_chopped = false;
                        water =false;
                        air = false;
                        animal = true;
                        garbage = false;
                        type="animal";
                        setState(() {

                        });

                      },
                      activeColor: Colors.red[900],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 35,right: 35,left: 35),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.left,
                  maxLength: 200,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: "Enter a short description. (optional)",border:OutlineInputBorder(borderRadius: BorderRadius.circular(10),),contentPadding: EdgeInsets.only(top: 100,left: 20)),
                  onChanged: (val){
                    setState(() {
                      this.reportDescription = val;
                    });
                    print(reportDescription);
                  },

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
                    icon: isReportPublished?Container(child: CircularProgressIndicator(strokeWidth: 2,color: Colors.white,),height: 20,width: 20,):Icon(Icons.report_gmailerrorred_rounded,color: Colors.white,),
                    label: Text("Report the problem",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
                    onPressed: () async{
                      setState(() {
                        isReportPublished = true;
                      });

                      DateTime today = DateTime.now();
                      showInSnackBar2("Do not go back. It may take some seconds", false);

                      Map<String,dynamic> setReportDataMap = {
                        "email":" ",
                        "location": completeInfo['location_of_report'],
                        "imageURL": null,
                        "description": reportDescription,
                        "name_of_person":"Amaan",
                        "type":type,
                        "date":today
                      };

                     isComplete = await setData.setReport(setReportDataMap);

                     if(isComplete)
                       {
                         Navigator.pushReplacementNamed(context, "/reportpublishedpage",);
                       }
                     else
                       {
                         showInSnackBar(" An error occurred",isComplete);
                         await Future.delayed(Duration(milliseconds: 2600));
                         Navigator.pop(context);
                       }

                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
