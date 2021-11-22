import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:planet/views/nursery_in_city_view_page3.dart';
import 'package:url_launcher/url_launcher.dart';

class DreiPage extends StatefulWidget {
  const DreiPage({Key? key}) : super(key: key);

  @override
  _DreiPageState createState() => _DreiPageState();
}

class _DreiPageState extends State<DreiPage>{

  List<Color> colorList = [Colors.redAccent,Colors.blueAccent,Colors.greenAccent];

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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 35,right: 35,top: 40),
                      child: Text("News and facts",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 35,right: 35,top: 20),
                      child: Text("Lets see what our planet is up to. May contain sensitive pictures.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 35,right: 35,top: 0,bottom: 20),
                      child: Text("Scroll left",style: TextStyle(color: Colors.grey[600],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 15),),
                    ),
                  ],
                ),

              ],
            ),

            Container(
              height: MediaQuery.of(context).size.height/3.5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context,index)
                {
                  return GestureDetector(
                    onTap: (){
                      String query = queryCreator(completeInfo['news${index+1}']['title'].toString()).toString();
                      launchURL("https://www.google.com/search?q="+query+"+latest+news");
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 27,right: 30,top: 0,bottom: 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.15,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            alignment:Alignment.bottomLeft,
                            children: [
                              ClipRRect(child: Image.network(
                                completeInfo['news${index+1}']['image'],
                                height: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(child: ColorFiltered(child: Lottie.network("https://assets1.lottiefiles.com/packages/lf20_1ezvulr6.json",),colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcATop),));
                                },
                                errorBuilder: (context,obj,StackTrace? st)
                                {
                                  return Container(color: colorList[index],child: Center(child:Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Lottie.asset("assets/animations/errorAnimation.json"),
                                      Text("No internet",style: TextStyle(color: Colors.white),)
                                    ],
                                  )),);
                                },
                              ),
                                borderRadius: BorderRadius.circular(30),),

                              Container(
                                height: MediaQuery.of(context).size.height/11,
                                decoration: BoxDecoration(
                                    color: Colors.black87,
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ColorFiltered(child: Lottie.asset("assets/animations/infoAnimation.json"),colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),),
                                      SizedBox(width: 10,),
                                      Expanded(child: Text( completeInfo['news${index+1}']['title'],overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w700),))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 50),
              child: Text("Beings saving planet",style: TextStyle(color: Colors.grey[800],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 22),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 20),
              child: Text("Contact dotdevelopingteam and get featured here.",style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 20,bottom: 0),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText(completeInfo['organization']['name'],textStyle: TextStyle(color: Colors.grey[700],fontSize: 18,fontFamily: "Lato",fontWeight: FontWeight.w700),colors: [Colors.black54,Colors.green]),
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 5),
              child: Text(completeInfo['organization']['desc'],style: TextStyle(color: Colors.grey[500],fontFamily: "Lato",fontWeight: FontWeight.w500,fontSize: 15),maxLines: 2,overflow: TextOverflow.ellipsis,),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35,right: 35,top: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width-70,
                child: ElevatedButton.icon(
                  autofocus: false,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                  ),
                  icon: Icon(Icons.public_rounded,color: Colors.white,),
                  label: Text("Visit them now!",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
                  onPressed: () {
                    launchURL(completeInfo['organization']['url'].toString());
                  },
                ),
              ),
            ),

            //from views
            //NurseryInCityView()
          ],
        ),
      ),
    );
  }
}

