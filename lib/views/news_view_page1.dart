import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:url_launcher/url_launcher.dart';

// to handle the news events.
//firebase fetch
//info for google querying

class NewsView extends StatelessWidget {


  launchURL(value) async {

    try{
      if(await canLaunch(value.toString()))
        {
          await launch(value.toString());
        }
    }
    catch (e)
    {
      print(e);
    }

  }

  queryCreator(String val)
  {
    String query ="";
    val = val.trim();
    for(int i=0;i<val.length;i++)
      {
        if(val[i]==" ")
          {
            query += "+";
          }
        else
          {
            query += val[i];
          }
      }
    query = query.toLowerCase();
    return query;
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(left: 30,right: 30,),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.grey[100],
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Center(child: Row(
            children: [
              IconButton(
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    ColorFiltered(child: Lottie.asset("assets/animations/liveAnimation.json",height: 50),colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcATop),),
                    Icon(Icons.info_outlined,color: Colors.grey[600],)
                  ],
                ),
                onPressed: (){
                  
                  //we launch google query
                  String query = queryCreator(completeInfo["news0"].toString());
                  print(query);
                  launchURL("https://www.google.com/search?q="+query+"+latest+news");
                },
              ),
              Expanded(child: Text(completeInfo["news0"].toString(),style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 18),overflow: TextOverflow.ellipsis,)),
            ],
          )),
        ),
      ),
    );
  }
}
