import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:terra_vision/home/Dashboard_elements/dashboard.dart';
import 'package:terra_vision/utilities/5_day_weather_list.dart';
import '../utilities/category.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
final _scaffoldKey= GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 100,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue.shade200)
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>const DashBoardScreen()), (route)=>true);
          },
          child: Icon(Icons.dashboard,color: Colors.blue.shade900,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      key:_scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Container(
             height: MediaQuery.of(context).size.height*0.42,
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
             /* Padding(
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
              ),*/
              Padding(
                padding: const EdgeInsets.only(top:130),
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
                            height:20,
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
       /*   Padding(
            padding: const EdgeInsets.only(top:90, left:10),
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
                  children:   [
                   Category_card(image:"images/location.png",text:"Location", skey:_scaffoldKey),
                   Category_card(image:"images/notification.jpg",text:"Notification", skey:_scaffoldKey),
                   Category_card(image:"images/sos.jpg",text:"SOS", skey: _scaffoldKey),
                   Category_card(image:"images/profile.jpg",text:"Profile", skey:_scaffoldKey),
                   Category_card(image: "images/settings.png",text:"Settings", skey: _scaffoldKey,),
                  ],
                  ),
                ),*/
          Padding(
            padding: const EdgeInsets.only(top:60, left:15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Next 5 days".toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView(
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent:160,
                crossAxisCount: 1,
              ),
              children:   const [
                WeatherList(day:"Tuesday",image:"images/weather.jpg", temp:"20 \u2103",),
                WeatherList(day:"Wednesday",image:"images/weather.jpg", temp:"34 \u2103"),
                WeatherList(day:"Thursday",image:"images/weather.jpg", temp:"25\u2103"),
                WeatherList(day:"Friday",image:"images/weather.jpg", temp:"31 \u2103"),
                WeatherList(day:"Saturday",image:"images/weather.jpg", temp:"18 \u2103"),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),


      );
  }
}