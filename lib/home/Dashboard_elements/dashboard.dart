import 'package:flutter/material.dart';

import '../../utilities/category.dart';

final _scaffoldKey= GlobalKey<ScaffoldState>();

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.dashboard, color: Colors.blue.shade900,),
        title: const Text(
          'DashBoard',
          style: TextStyle(
            letterSpacing: 3,
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            fontFamily: 'PlayFair Date',
          ),
        ),
        elevation: 10,
      ),
      body:Padding(
        padding: const EdgeInsets.only(top:20,left:10, right: 10),
        child: GridView(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:2,
               mainAxisSpacing: 4,

          ),
          children: [
            Category_card(image:"images/location.png",text:"Location", skey:_scaffoldKey),
            Category_card(image:"images/notification.jpg",text:"Notification", skey:_scaffoldKey),
            Category_card(image:"images/camera.png",text:"Reporting", skey: _scaffoldKey),
            Category_card(image:"images/house.jpg",text:"After Flood reporting", skey:_scaffoldKey),
            Category_card(image: "images/profile.jpg",text:"Profile", skey: _scaffoldKey,),
            Category_card(image: "images/settings.png",text:"Settings", skey: _scaffoldKey,),
          ],
        ),
      )
    );
  }
}
