

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:terra_vision/home/Dashboard_elements/profile.dart';

class Category_card extends StatelessWidget {
  final String image;
  final String text;
  final skey;
  const Category_card({
    Key? key,required this.image, required this.text, required this.skey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       /* if(text=="SOS")
          {
            skey.currentState.showSnackBar(
              SnackBar(
                backgroundColor: Colors.red.shade50,
                content:Container(
                  width: 30,
                  height:100,
                  child: Column(
                    children: [
                      const Text(
                        'Do you want to send SOS?',
                        style: TextStyle(
                          color:Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize:18,
                        ),
                      ),
                      const SizedBox(
                        height:10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(

                              onPressed: (){},
                              child: const Text(
                            "Yes",
                          ),),
                          ElevatedButton(
                              onPressed: (){
                                skey.currentState.hideCurrentSnackBar();
                              },
                              child: const Text(
                                "No"
                              ))

                        ],
                      )

                    ],
                  )
                )
              )
            );
          }*/
        if(text=="Profile")
          {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>const Profile()), (route)=>true);

          }
      },
      child: Padding(
        padding: const EdgeInsets.only(left:8, right:8),
        child: Container(
          height:30,
          width:50,
          child: Card(
            elevation: 5,
            color: Colors.white,
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image,
                  height:30,
                  width:50,
                ),
                const SizedBox(
                  height:8,
                ),
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontFamily: 'Playfair Date',
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
