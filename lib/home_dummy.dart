import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
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

  void _getPermissions() async{
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }else if(permission == LocationPermission.deniedForever){
        print("'Location permissions are permanently denied");
      }else{
        print("GPS Location service is granted");
      }
    }else{
      print("GPS Location permission granted.");
    }
  }

  void _getCurrentLocation() async{
    print("Entering getcurrentlocation");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true).then((position) {
      _currentPosition = position;
      print(_currentPosition);
    }).catchError((e) {
      print(e);
    });
  }
  @override
  void initState() {
    super.initState();
    _getPermissions();
    _getCurrentLocation();

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
                              "Sdfhdshfj",
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

Future<WeatherModel?> WeatherApiCall()async{
  var api_url='https://api.openweathermap.org/data/2.5/weather?lat=26.1296084&lon=91.6191235&appid=e4b7e9a7c209d3153d1964b820ffa2f3';
  var response;
  print(api_url);
  response=
  await http.get(Uri.parse(api_url)).whenComplete((){print(response.body);});
  //print(response);
  if (response.statusCode == 200) {
    WeatherModel model= WeatherModel.fromJson(jsonDecode(response.body));
    print(model);
    return model;
  }
  else
    print(response.statusCode);

}


// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

//WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

//String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    coord: Coord.fromJson(json["coord"]),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    base: json["base"],
    main: Main.fromJson(json["main"]),
    visibility: json["visibility"],
    wind: Wind.fromJson(json["wind"]),
    clouds: Clouds.fromJson(json["clouds"]),
    dt: json["dt"],
    sys: Sys.fromJson(json["sys"]),
    timezone: json["timezone"],
    id: json["id"],
    name: json["name"],
    cod: json["cod"],
  );

  Map<String, dynamic> toJson() => {
    "coord": coord.toJson(),
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "base": base,
    "main": main.toJson(),
    "visibility": visibility,
    "wind": wind.toJson(),
    "clouds": clouds.toJson(),
    "dt": dt,
    "sys": sys.toJson(),
    "timezone": timezone,
    "id": id,
    "name": name,
    "cod": cod,
  };
}

class Clouds {
  Clouds({
    required this.all,
  });

  int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  double lon;
  double lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lon: json["lon"].toDouble(),
    lat: json["lat"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lon": lon,
    "lat": lat,
  };
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json["temp"].toDouble(),
    feelsLike: json["feels_like"].toDouble(),
    tempMin: json["temp_min"].toDouble(),
    tempMax: json["temp_max"].toDouble(),
    pressure: json["pressure"],
    humidity: json["humidity"],
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "humidity": humidity,
  };
}

class Sys {
  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    type: json["type"],
    id: json["id"],
    country: json["country"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "country": country,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  int speed;
  int deg;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"],
    deg: json["deg"],
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
  };
}


import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:terra_vision/home/Dashboard_elements/dashboard.dart';
import 'package:terra_vision/utilities/5_day_weather_list.dart';
import '../helper_models/5_day_weather_model.dart';
import '../helper_models/weather_model.dart';
import '../utilities/category.dart';
import 'package:terra_vision/services/geolocation.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Variable declaration
final _scaffoldKey= GlobalKey<ScaffoldState>();
//late Future<WeatherModel?> obj;
//late Future<WeatherModel2> obj2;
var  icon_url="";



class _HomeScreenState extends State<HomeScreen> {
  Position _currentPosition = const Position(latitude: 0, longitude: 0, altitude: 0, accuracy: 0, speed: 0, heading: 0,  speedAccuracy: 2, timestamp: null);

  Future<void> _getPermissions() async{
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
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true).then((position) {
      _currentPosition = position;
      print(_currentPosition);
    }).catchError((e) {
      print(e);
    });
  }

  Future<WeatherModel?> WeatherApiCall()async{
    var apiUrl='https://api.openweathermap.org/data/2.5/weather?lat=${_currentPosition.latitude}&lon=${_currentPosition.longitude}&appid=e4b7e9a7c209d3153d1964b820ffa2f3&units=metric';
    var response = await http.get(Uri.parse(apiUrl), headers: {'Accept': 'application/json'});
    print(apiUrl);
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
  void initState() {
    _loading = true;
    super.initState();
    _getPermissions().then((value) =>
        _getCurrentLocation().then((value) =>
            WeatherApiCall().then((value)
            {
              setState(()
              {_weather = value!;
              _loading = false;
                Days5WeatherApiCall().then((value) => {
                setState((){
                  _weather2=value!;
                  _loading=false;
                })
              });
              }

              );
            }),),);

  }

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
                              DateFormat.yMMMEd().format(DateTime.now()),
                              // DateTime.now().toString().substring(0,10),
                              style:const TextStyle(
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
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      height:10,
                                    ),
                                    Text(
                                      "${_weather.main.temp.toInt()} \u2103",
                                      style: const TextStyle(
                                        fontSize: 35,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /* Image.asset("images/weather.jpg",
                                width:100,
                                height: 100,),*/
                              SizedBox(
                                  height:120,
                                  width:120,
                                  child: Image.network('http://openweathermap.org/img/w/${_weather.weather[0].icon}.png',)
                              ),
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
              children:    [
                WeatherList(day:"${_weather2.list[0].dt}",image:'http://openweathermap.org/img/w/${_weather2.list[0].weather[3].icon}.png', temp:"20 \u2103",),
                WeatherList(day:"${_weather2.list[1].dt}",image:'http://openweathermap.org/img/w/${_weather2.list[1].weather[3].icon}.png', temp:"34 \u2103"),
                WeatherList(day:"${_weather2.list[2].dt}",image:'http://openweathermap.org/img/w/${_weather2.list[2].weather[3].icon}.png', temp:"25\u2103"),
                WeatherList(day:"${_weather2.list[3].dt}",image:'http://openweathermap.org/img/w/${_weather2.list[3].weather[3].icon}.png', temp:"31 \u2103"),
                WeatherList(day:"${_weather2.list[4].dt}",image:'http://openweathermap.org/img/w/${_weather2.list[1].weather[3].icon}.png', temp:"18 \u2103"),
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
