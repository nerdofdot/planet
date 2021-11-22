import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:planet/pages/drei_page.dart';
import 'package:planet/pages/eins_page.dart';
import 'package:planet/pages/funf_page.dart';
import 'package:planet/pages/vier_page.dart';
import 'package:planet/pages/zwei_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  List wig = [EinsPage(),ZweiPage(),DreiPage(),VierPage(),FunfPage()];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: wig[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        elevation: 0,
        blurEffect: true,
        unSelectedColor: Colors.grey[700],
        backgroundColor: Colors.white,
        iconSize: 27,
        selectedColor: Colors.green[800],
        currentIndex: _currentIndex,
        strokeColor: Colors.white,
        borderRadius: Radius.circular(15),
        onTap: (value){
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          CustomNavigationBarItem(
            icon: Icon(Icons.park_outlined),
          ),
          CustomNavigationBarItem(
            icon: Icon(Icons.nature_people_outlined),
          ),
          CustomNavigationBarItem(
            icon: Icon(Icons.public_rounded),
          ),
          CustomNavigationBarItem(
            icon: Icon(Icons.eco_outlined),
          ),
          CustomNavigationBarItem(
            icon: Icon(Icons.info_outline_rounded),
          ),
        ],
      ),

    );
  }
}
