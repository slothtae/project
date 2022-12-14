import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:terra_vision/helper_models/5_day_weather_model.dart';
import 'package:terra_vision/home/Dashboard_elements/dashboard.dart';
import 'package:terra_vision/utilities/5_day_weather_list.dart';
import '../helper_models/weather_model.dart';
import '../utilities/category.dart';
import 'package:terra_vision/services/geolocation.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Variable declaration
final _scaffoldKey= GlobalKey<ScaffoldState>();
//late Position? _currentPosition=null;
late Future<WeatherModel?> obj;



class _HomeScreenState extends State<HomeScreen> {

  //This function gives the latitude and longitude of the device
  /*_determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    print("Entering the determinePosition function");
    _currentPosition=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true).then((value) { print("Inside then");});
    print("Hi");
    print(_currentPosition?.latitude);
    print(_currentPosition?.longitude);
    print("hey");
  }*/
  Position _currentPosition = const Position(latitude: 0, longitude: 0, altitude: 0, accuracy: 0, speed: 0, heading: 0,  speedAccuracy: 2, timestamp: null);

  Future<void> _getPermissions() async{
    print("Entered get persmissions");
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }else if(permission == LocationPermission.deniedForever){
        print("'Location permissions are permanently denied");
      }else{
        _getCurrentLocation();
        print("GPS Location service is granted");
      }
    }else{
      print("GPS Location permission granted.");
    }
  }

  Future<void> _getCurrentLocation() async{
    print("Entering getcurrentlocation");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest, forceAndroidLocationManager: true,).then((position) {
      _currentPosition = position;
      print(_currentPosition);
    }).catchError((e) {
      print(e);
    });
    print("Out of getcurrent location");
  }

  Future<WeatherModel?> WeatherApiCall()async{
    print('Entereing weather api call');
    var api_url='https://api.openweathermap.org/data/2.5/weather?lat=${_currentPosition.latitude}&lon=${_currentPosition.longitude}&appid=e4b7e9a7c209d3153d1964b820ffa2f3&units=metric';
    var response = await http.get(Uri.parse(api_url), headers: {'Accept': 'application/json'});
    print(api_url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      WeatherModel model = WeatherModel.fromJson(data);
      print(model.name);
      return model;
    }
    else
    {
      print(response.statusCode);
      return null;
    }

  }
  Future<WeatherModel2?> Days5WeatherApiCall()async{
    var apiUrl='https://api.openweathermap.org/data/2.5/forecast?lat=${_currentPosition.latitude}&lon=${_currentPosition.longitude}&appid=e4b7e9a7c209d3153d1964b820ffa2f3';
    var response = await http.get(Uri.parse(apiUrl), headers: {'Accept': 'application/json'});
    print(apiUrl);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      WeatherModel2 model = WeatherModel2.fromJson(data);
      print(model);
      // print(model.name);
      return model;
    }
    else
    {
      print(response.statusCode);
      return null;
    }

  }

  late WeatherModel _weather;
  late WeatherModel2 _weather2;
  bool _loading = false;

  @override
  /*void initState() {
    _loading = true;
    super.initState();
    _getPermissions().then((value) => _getCurrentLocation().then((value) => WeatherApiCall().then((value){setState(() {_weather = value!; _loading = false;});})));

  }*/
  void initState() {
    _loading = true;
    super.initState();
    _getPermissions().then((value) =>
        _getCurrentLocation().then((value) =>
            WeatherApiCall().then((value)
            {
              //setState(()
              //{
                _weather = value!;
                // _loading = false;
                Days5WeatherApiCall().then((value) => {
                setState((){
                _weather2=value!;
                _loading=false;
                })
                    //});
                    // }
                    // }
                }
              );
            }),),);

  }
  /*void initState ()
  {
    print("hello world");
    //_determinePosition();
    obj= WeatherApiCall();
    super.initState();
  }*/

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
      body: (_loading==true) ?
      const Center(
        child: CircularProgressIndicator(),
      ):
      Column(
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
                          Text(
                              _weather.name,
                              style:const TextStyle(
                                color: Colors.grey,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          Text(
                            // 'Monday, 24th Aug',
                              DateTime.now().toString().substring(0,10),
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
                                  children: [
                                    Text(
                                      // "Partly Cloudy",
                                      _weather.weather[0].main,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height:10,
                                    ),
                                    Text(
                                      "${_weather.main.temp.toInt()} \u2103",
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
