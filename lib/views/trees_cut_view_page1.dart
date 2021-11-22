import 'dart:math';

import 'package:flutter/material.dart';
class TreesCutView extends StatefulWidget {
  const TreesCutView({Key? key}) : super(key: key);
  @override
  _TreesCutViewState createState() => _TreesCutViewState();
}

int rateperSecond = 2;
int totalCount = 0;
Random random = Random(5);

class _TreesCutViewState extends State<TreesCutView> {



  getTreeCutDown() async
  {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      totalCount += rateperSecond + random.nextInt(5);
      // called a function which is above
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalCount += random.nextInt(7);
  }

  @override
  Widget build(BuildContext context) {
    getTreeCutDown();
    return Padding(
      padding: EdgeInsets.only(left: 30,right: 30,),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Trees cut since you logged in:",style: TextStyle(color: Colors.orange[700],fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
              Opacity(child: Text(totalCount.toString(),style: TextStyle(color: Colors.orange[700],fontFamily: "Lato",fontWeight: FontWeight.w700,fontSize: 50),),opacity:0.5,),
            ],
          ),
        ),
      ),
    );
  }
}
