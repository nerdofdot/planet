import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/backend_firebase/getter_database.dart';
import 'package:planet/flow_pages/error_page.dart';
import 'package:planet/flow_pages/home_page.dart';
import 'package:planet/flow_pages/signup_page.dart';



class LoadingSplashScreen extends StatefulWidget {
  const LoadingSplashScreen({Key? key}) : super(key: key);

  @override
  _LoadingSplashScreenState createState() => _LoadingSplashScreenState();
}

var completeInfo = null;

class _LoadingSplashScreenState extends State<LoadingSplashScreen> {

  FetchDatabase fetchDatabase = FetchDatabase();

  late Future<dynamic> fetchInformation;
  late Map<String,dynamic> fetchedInformationinMap;

  getData()async{

    fetchInformation = fetchDatabase.getAllData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: fetchInformation,
        builder: (context,snapshot)
        {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return LoadingWidget();
            }
          else if(snapshot.hasData)
            {
              completeInfo = snapshot.data;
              print("************************************************************");
              print(completeInfo);
              return HomePage();
            }
          else if(snapshot.hasError)
            {
              print(snapshot.error);
              return ErrorPageMain();
            }
          else
            {
              return Container(color: Colors.blue,);
            }
        },
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Opacity(child: Text("Lets save our planet",style: TextStyle(fontSize: 20,color: Colors.deepPurple,fontFamily: "Lato",fontWeight: FontWeight.w700),),opacity: 0.5,),
              Lottie.asset("assets/animations/paperplaneAnimation.json"),
            ],
          ),
          Text("Loading, please wait...",style: TextStyle(fontSize: 16,color: Colors.grey,fontFamily: "Lato",fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }
}



