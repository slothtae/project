import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';


class Location extends StatefulWidget{
  const Location({Key?key}):super(key:key);
  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location>{
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref("live_water_level");
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(26.129267668345395, 91.62045250545616),
    zoom: 20,
  );
  late var _nodes;
  late Set<Circle> _circles;
  late Set<Marker> _markers;
  late StreamSubscription<DatabaseEvent> _waterSubscription;

  void initState() {
    setState(() {
	_circles = Set.from([]);
	_markers = Set.from([]);
    });
    _init();
    _getData();
    super.initState();
  }

  Future<void> _init() async{
    DatabaseReference _waterRef = FirebaseDatabase.instance.ref("live_water_level");
    final messageQuery = _waterRef;
    _waterSubscription = messageQuery.onChildChanged.listen(
      (DatabaseEvent event){
	_getData();
      },
      onError: (Object o){
	final error = o as FirebaseException;
	print('Error: ${error.code} ${error.message}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
	title:Center(
		child:Text("Location"),
	),
	flexibleSpace: Container(
      	  decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xFFEF9A94),
                Color(0xFFFFEBEE),
              ]),

          ),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
	myLocationEnabled: true,
	myLocationButtonEnabled: true,
	compassEnabled: true,
	circles:_circles,
	markers:_markers,
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed:()=> _getData(),
        label: Text(''),
        icon: Icon(Icons.refresh),
      ),*/
    );
  }
  Future<void> _getData() async{ 
     final DatabaseEvent event = await ref.once(); 
     final json = event.snapshot.value as Map<dynamic ,dynamic>;
     late List circles=[];
     late List markers=[];
     late Color colour;
     for(var j in json.entries){
       var node_name = j.key;
       var water_level = j.value['water'];
       if (water_level >= 100) {colour = Colors.redAccent;}
       else if(water_level < 100 && water_level >= 50) {colour = Colors.orangeAccent;}
       else if(water_level < 50 && water_level >= 15) {colour = Colors.yellow;}  
       else {colour = Colors.greenAccent;}
       circles.add(
         Circle(
           circleId: CircleId(j.key),
             center: LatLng(j.value['lat'],j.value['lon']),
	     radius: 1000, //1km
	     fillColor: colour.withOpacity(0.1),
	     strokeColor: colour.withOpacity(0.5),
	     strokeWidth: 10,
	)
      );
      markers.add(
        Marker(
          markerId: MarkerId(j.key),
          position: LatLng(j.value['lat'],j.value['lon']),
	  infoWindow: InfoWindow(
	    title: node_name,
	    snippet: "water level at $node_name : $water_level cm",
	  ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() { 
        _circles = Set.from(circles);
        _markers = Set.from(markers);
      });	
    }
  }
  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
}
