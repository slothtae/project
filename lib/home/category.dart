

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category_card extends StatelessWidget {
  final String image;
  final String text;
  const Category_card({
    Key? key,required this.image, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    fontSize: 15),)
            ],
          ),
        ),
      ),
    );
  }
}
