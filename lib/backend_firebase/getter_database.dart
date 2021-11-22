import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FetchDatabase
{
  final database_cloud_firestore = FirebaseFirestore.instance;
  final database_real_time = FirebaseDatabase();


  Future<dynamic> getAllData() async
  {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user;

    await Firebase.initializeApp();
    final User? firebaseUser = await FirebaseAuth.instance.currentUser;
    await firebaseUser!.reload();
    _user = await _auth.currentUser;

    var newsDetails = await database_real_time.reference().child("newsPage").once().then((value) => value.value).timeout(Duration(seconds: 10));

    Map newsDetailsMap = newsDetails;

    Map<String,dynamic> locationMap = {
      "country":null,
      "city":null,
      "location_lat":null,
      "location_long":null,
      "isLocationEnabled":false,
    };

    Map<String,dynamic> reportMap = {
      "location_of_report":null,
      "imageFile":null,
      "description":null,
      "date_of_report":null,
      "imageURL":null,
      "imageOfUser":_user!.photoURL,
      "nameOfUser":_user.displayName,
      "email":_user.email.toString(),
    };

    Map<String,dynamic> qrCodeMap = {
      "nameOfNursery":null,
      "nameOfPlant": null,
      "typeOfPlant":null,
      "price":null,
      "minTemp":null,
      "maxTemp":null,
      "isWaterNeeded":null,
      "isSunNeeded":null,
      "isChemicalNeeded":null,
      "care":null,
    };

    var map1 = await database_cloud_firestore.collection("A").doc("tracker").get().then((value) => value.data());
    
    var userReports = await database_cloud_firestore.collection(_user.email.toString()).doc("report").get().then((value) => value.data());

    reportMap['date_of_report'] = userReports!['date'];
    reportMap['imageURL'] = userReports['imageURL'];

    Map<String,dynamic> completeData = {...map1!,...locationMap,...reportMap,...userReports,...newsDetailsMap,...qrCodeMap};
    print(completeData);
    //await Future.delayed(Duration(seconds: 1));
    return completeData;

  }

}