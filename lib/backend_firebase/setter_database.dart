import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:planet/flow_pages/loading_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SetData
{
  final database_cloud_firestore = FirebaseFirestore.instance;
  final database_real_time = FirebaseDatabase();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;



  Future<bool> setDPlantingRequest(String colName,String docName,Map<String,dynamic> setMap) async
  {
    bool isDone = false;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user;

    await Firebase.initializeApp();
    final User? firebaseUser = await FirebaseAuth.instance.currentUser;
    await firebaseUser!.reload();
    _user = await _auth.currentUser;

    await FirebaseFirestore.instance.runTransaction((transaction)async
    {
      DocumentReference postRef = FirebaseFirestore.instance.collection('A').doc("tracker");
      DocumentSnapshot snapshot = await transaction.get(postRef);
      int plantRequestInDatabase = snapshot.get("no_of_requests");
      completeInfo["no_of_requests"] = plantRequestInDatabase;

      setMap["email"] = _user!.email.toString();

      Map<String,dynamic> mapToBeUpdated = {
        "request${plantRequestInDatabase}":setMap
      };
      try
      {

        await database_cloud_firestore.collection(colName).doc(docName).update(mapToBeUpdated).whenComplete(() => isDone=true);
      }
      catch (e)
      {
        await database_cloud_firestore.collection(colName).doc(docName).set(mapToBeUpdated).whenComplete(() => isDone=true);
      }
      transaction.update(postRef,{'no_of_requests' : completeInfo["no_of_requests"]+1});
    }).catchError((err){
      isDone = false;
    });

    return isDone;
  }

  Future<bool> setReport(Map<String,dynamic> setMap) async
  {
    bool isDone = false;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user;

    await Firebase.initializeApp();
    final User? firebaseUser = await FirebaseAuth.instance.currentUser;
    await firebaseUser!.reload();
    _user = await _auth.currentUser;

    setMap["email"] = _user!.email.toString();
    setMap['name_of_person'] = _user.displayName.toString();


    bool isComplete = false;
    DateTime todaysdate = DateTime.now();
    String imagePath = "images/"+completeInfo["country"]+"/"+_user.email.toString()+"-"+todaysdate.day.toString()+"-"+todaysdate.month.toString()+"-"+todaysdate.year.toString()+".jpg";

    try {
          await firebase_storage.FirebaseStorage.instance.ref(imagePath).putFile(completeInfo['imageFile']).whenComplete(()async{
            String downloadURL = await firebase_storage.FirebaseStorage.instance.ref(imagePath).getDownloadURL();
            print("HOHOHOHOHO#####################################################0");
            print(downloadURL);
            setMap['imageURL'] = downloadURL;
          });


          await FirebaseFirestore.instance.runTransaction((transaction)async
          {
            DocumentReference postRef = FirebaseFirestore.instance.collection('A').doc("tracker");
            DocumentSnapshot snapshot = await transaction.get(postRef);
            int reportInDatabase = snapshot.get("no_of_reports");
            Map<String,dynamic> mapToBeUpdated = {
              "report${reportInDatabase}":setMap
            };

            try
            {
              await database_cloud_firestore.collection(completeInfo['country']).doc(completeInfo['city']).collection("report").doc(setMap['type']).update(mapToBeUpdated);
            }
            catch(erer)
            {
              print(erer.toString());
              await database_cloud_firestore.collection(completeInfo['country']).doc(completeInfo['city']).collection("report").doc(setMap['type']).set(mapToBeUpdated);
            }

            try
            {
              Map<String,dynamic> setMapForUser ={
                "date":Timestamp.now(),
                "type":setMap['type'],
                "previous_report":true,
                "imageURL": setMap['imageURL']
              };
              await database_cloud_firestore.collection(_user!.email.toString()).doc("report").set(setMapForUser).whenComplete(() {
                completeInfo['date_of_report'] = Timestamp.now();
                completeInfo['type'] = setMap['type'];
                completeInfo['previous_report'] = true;
                completeInfo['imageURL'] = setMap['imageURL'];
                isComplete = true;
              });
            }
            catch(ex)
            {

            }

            transaction.update(postRef,{'no_of_reports' : reportInDatabase+1});
          }).catchError((err){
            isComplete = false;
          });

          return isComplete;
    }
    on firebase_storage.FirebaseException catch(e)
    {
      print(e.toString());
      isComplete = false;
      return isComplete;
      }
    }


    Future<bool> setNewUser() async
    {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      User? _user;

      bool isSet = false;

      await Firebase.initializeApp();
      final User? firebaseUser = FirebaseAuth.instance.currentUser;
      print(firebaseUser);
      await firebaseUser!.reload();
      _user = await _auth.currentUser;
      print(_user);




      Map<String,dynamic> newUserMap ={
        "date":Timestamp.now(),
        "imageURL":" ",
        "previous_report":false,
        "type":"tree",
      };


      await database_cloud_firestore.collection(_user!.email.toString()).doc("report").set(newUserMap).whenComplete((){
        isSet = true;
      }).catchError((er){
        isSet = false;
      });

      return isSet;
    }



}