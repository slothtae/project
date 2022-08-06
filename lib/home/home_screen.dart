import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'category.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Container(
             height: MediaQuery.of(context).size.height*0.45,
              decoration: const BoxDecoration(
                  image:DecorationImage(
                    image:AssetImage("images/cloud.jpg",),
                    opacity: 0.7,
                    fit:BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
              ),child:Stack(
            children:
            [
              Padding(
                padding: const EdgeInsets.only(top:100, left:20, right:20),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.search,
                      color:Colors.grey,
                    ),
                    hintStyle: const TextStyle(color:Colors.grey, fontWeight: FontWeight.bold,letterSpacing: 5),
                    hintText:'Search',
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color:Colors.white),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color:Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color:Colors.white),
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:250),
                child: OverflowBox(
                  minWidth: 0.0,
                  maxWidth: (MediaQuery.of(context).size.width),
                  minHeight: 0.0,
                  maxHeight: (MediaQuery.of(context).size.height/3),
                  child: Container(
                    padding: const EdgeInsets.only(right:10, left:10),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children:  [
                          const SizedBox(
                            height:10,
                          ),
                          const Text(
                              'Guwahati',
                              style:TextStyle(
                                color: Colors.grey,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          const Text(
                              'Monday, 24th Aug',
                              style:TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              )
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Partly Cloudy",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height:10,
                                    ),
                                    Text(
                                      "19 \u2103",
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset("images/weather.jpg",
                                width:100,
                                height: 100,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:100, left:10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "DashBoard".toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children:  const [
                   Category_card(image:"images/location.png",text:"Location"),
                   Category_card(image:"images/notification.jpg",text:"Notification"),
                   Category_card(image:"images/sos.jpg",text:"SOS"),
                   Category_card(image:"images/profile.jpg",text:"Profile"),
                   Category_card(image: "images/settings.png",text:"Settings"),
                  ],
                  ),
                ),
        ],
      ),
      );
  }
}
