import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:planet/flow_pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:planet/flow_pages/onboarding_page.dart';


class SignupButton extends StatelessWidget {

  String? name;
  String? email;
  String? imageUrl;

  User? user;


  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();


//this key is for Scaffold snackbar display
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  Future<User?> _signIn() async
  {
    print("ghghghghggggggggggggggggggggggggggg############################");
    //these lines are used to sign in the user with Google Auth
    await Firebase.initializeApp();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    // final AuthResult authResult = await auth.signInWithCredential(credential);
    // final User user = authResult.user;

    user = (await auth.signInWithCredential(credential)).user;
    if (user != null) {
      name = user!.displayName;
      email = user!.email;
      imageUrl = user!.photoURL;
    }
    print("ghghghghggggggggggggggggggggggggggg############################");
    print(user);
    return user;
  }

  void showToast(BuildContext context,String value) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
          backgroundColor: Colors.black,
          duration: Duration(seconds: 1),
          content: Row(
            children: [
              Icon(Icons.error_outline,color: Colors.white,),
              Text(value,style: TextStyle(color: Colors.white,fontFamily: "Lato"),)
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 35,right: 35,top: 20,bottom: 30),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width-70,
        child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
          ),
          icon: Image.asset("assets/images/google.png",height:27,color: Colors.white,),
          label: Text("Sign up now",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontWeight: FontWeight.w600,fontSize: 16),),
          onPressed: () {
            _signIn().whenComplete(() {
              print("you");
              print(user!.displayName);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => OnBoardingPage()),
                      (Route<dynamic> route) => false);
            }).catchError((onError) {
             print(onError);
             showToast(context, "  An error occurred. Try again");
            });
          },
        ),
      ),
    );
  }
}
