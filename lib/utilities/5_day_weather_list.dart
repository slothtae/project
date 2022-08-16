import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

  class WeatherList extends StatelessWidget {
  final String day;
  final String image;
  final String temp;
  const WeatherList({Key? key, required this.image, required this.day, required this.temp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20,left:10),
   child:  Card(
     elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children:[
          const SizedBox(
            height:20,
          ),
           Text(
           day,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height:10,
          ),
          SizedBox(
              height:60,
              width:60,
              child: Image.asset(image)),
          const SizedBox(
            height:15,
          ),
           Text(
            temp,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    ),
    );
  }
}
