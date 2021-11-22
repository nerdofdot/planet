import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class DonationButtonView extends StatelessWidget {
  const DonationButtonView({Key? key}) : super(key: key);

  void launchEmailSubmission() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'nerdofdot@gmail.com',
        query: 'subject=Hey NERD!&body=The PLANET app is fantastic! And so I wanted to contact you because...........'
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 35,top: 20),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width-140,
        child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
          ),
          icon: Icon(Icons.messenger_outline_rounded,color: Colors.white,),
          label: Text("Contact nerdofdot",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
          onPressed: () {
            launchEmailSubmission();
          },
        ),
      ),
    );
  }
}
