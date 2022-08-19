

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  const Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      leading: Icon(Icons.arrow_back_ios, color: Colors.blueGrey,),
      title: const Text(
        "Camera",
        style: TextStyle(
          letterSpacing: 2,
          fontSize: 19,
          fontWeight: FontWeight.bold,
          fontFamily: 'PlayFair Date',
          color: Colors.blueGrey,
        ),
      ),
      elevation: 5,
    ),
    );
  }
}
