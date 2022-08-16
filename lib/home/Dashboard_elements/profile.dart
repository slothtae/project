import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:Colors.blueGrey),
        backgroundColor: Colors.white,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            letterSpacing: 2,
            color: Colors.blueGrey,
            fontFamily: "PlayFair Date",
            fontWeight: FontWeight.bold

          ),
        ),
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:40, left:20, right:20),
          child: Column(
            children: const [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/profile_picture.jpg"),
                  radius: 70,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Name Here'
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}
