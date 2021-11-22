import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/flow_pages/loading_page.dart';

class RecentReportView extends StatelessWidget {
  const RecentReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 35,right: 35,top: 60),
          child: Text("Your recent report",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
        ),
        Padding(
          padding: EdgeInsets.only(left: 35,right: 35,top: 20,bottom: 10),
          child: Text("Please feel free to raise your phone and snap the anti-environmental activity.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
        ),
        Padding(
          padding: EdgeInsets.only(right: 30,left: 30),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
                color: Colors.grey[100],
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: completeInfo['previous_report']?WithReport():WithNoReport(),
            ),
          ),
        )
      ],
    );
  }
}

class WithReport extends StatelessWidget {
  const WithReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime reportDate = completeInfo['date_of_report'].toDate();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(reportDate.day.toString()+"/"+reportDate.month.toString()+"/"+reportDate.year.toString()+"       "+reportDate.hour.toString()+":"+reportDate.minute.toString(),style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 18),),
          SizedBox(height: 10,),
          Text("You reported "+completeInfo['type']+" problem. A great step. We need more people like you.",overflow: TextOverflow.ellipsis,maxLines: 3,style: TextStyle(color: Colors.grey[600],fontFamily: "Lato"),),
          SizedBox(height: 10,),
          Container(child: ClipRRect(
            child: Image.network(
              completeInfo['imageURL'],
              fit: BoxFit.cover,
            errorBuilder: (context,ob,StackTrace? st)
              {
                return Container(color: Colors.grey[300],child: Center(child:Stack(
                  alignment: Alignment.center,
                  children: [
                    Lottie.asset("assets/animations/errorAnimation.json"),
                    Text("No internet",style: TextStyle(color: Colors.white),)
                  ],
                )),);
              },
            loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child: ColorFiltered(child: Lottie.network("https://assets1.lottiefiles.com/packages/lf20_1ezvulr6.json",),colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcATop),));
            },
            )
            ,borderRadius: BorderRadius.circular(30),),height: 300,width: MediaQuery.of(context).size.width,),
          SizedBox(height: 10,),
          Text("The image is secured by planet.",overflow: TextOverflow.ellipsis,maxLines: 3,style: TextStyle(color: Colors.grey[600],fontFamily: "Lato"),),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}

class WithNoReport extends StatelessWidget {
  const WithNoReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Text("No reports made yet.",overflow: TextOverflow.ellipsis,maxLines: 3,style: TextStyle(color: Colors.grey[600],fontFamily: "Lato"),),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}


