import 'package:flutter/material.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:url_launcher/url_launcher.dart';

class PlantNameView extends StatelessWidget {
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
      padding: EdgeInsets.only(left: 35,right: 35,top: 40),
      child: Row(
        children: [
          Text(completeInfo['nameOfPlant'].toString(),style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
          IconButton(
            icon: Icon(Icons.info_outlined,size: 30,color: Colors.grey[700],),
            onPressed: () {
              String query = queryCreator(completeInfo['nameOfPlant'].toString());
              print(query);
              launchURL("https://www.google.com/search?q="+query+"+plant+info");
            },
          )
        ],
      ),
    );
  }
}
