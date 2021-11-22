import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planet/extended_views/plant_a_tree_page.dart';
import 'package:planet/extended_views/plant_info_page.dart';
import 'package:planet/extended_views/qr_code_scanner_page.dart';
import 'package:planet/extended_views/report_activity_final_page.dart';
import 'package:planet/extended_views/report_activity_map_page.dart';
import 'package:planet/extended_views/report_activity_page.dart';
import 'package:planet/extended_views/report_published.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:planet/flow_pages/signup_page.dart';
import 'package:planet/flow_pages/start_page.dart';

import 'flow_pages/error_page.dart';
import 'flow_pages/onboarding_page.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      home: StartPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      routes: {
        "/plantInfo": (context) => PlantInfoPage(),
        "/plantatree": (context) => PlantATreePage(),
        "/reportactivity": (context) => ReportActivityPage(),
        "/reportactivitymap" :(context) =>GoogleMapLocationPage(),
        "/reportactivityfinal":(context) =>ReportActivityFinalPage(),
        "/reportpublishedpage":(context) => ReportPublishedPage(),
        "/toQR":(context) => QRCodeScannerPage(),
        "/signuppage":(context) => SignUpPage(),
      },
    ));
  });
}
