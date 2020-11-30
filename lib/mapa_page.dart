import 'dart:async';
import 'dart:convert';

//import 'package:covid/models/compartir_bloc.dart';
import 'package:covid/models/coordenadas_providers.dart';
import 'package:covid/models/parroquia_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';

import 'main.dart';


class MapSample extends StatefulWidget {

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  //CoordenadasProvider data = CoordenadasProvider();
  String ruta = 'alaquez';
  //
  static LatLng inicialPosition = LatLng(-0.933770, -78.610645);
  String archivoParroquia='la_matriz';
  List<LatLng> coordenadas = [];
  Future<String> loadDataFromJson() async{
    return await rootBundle.loadString('assets/json/$archivoParroquia.json');
  }

  Future loadData() async{
    String jsonString = await loadDataFromJson();
    final jsonRespose = json.decode(jsonString);
    Parroquia parroquia = new Parroquia.fromJson(jsonRespose);
    List<List<double>> coords = parroquia.coordinates;
    for (var item in coords) {
      //print(item[1]);
      //print(item[0]);
      coordenadas.add(LatLng(item[1],item[0]));
      //coordenadas=[item[1],item[0]];
    }
    //
    print('######################');
    print(coordenadas.length);
    inicialPosition=coordenadas[1];
    print('######################');
    //
  }
  @override
  void initState() { 
    super.initState();
    loadData();
  }
  //


  Completer<GoogleMapController> _controller = Completer();
  final Set<Heatmap> _heatmaps = {};
  final Set<Polygon> _poligns = {};
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: inicialPosition,
    zoom: 14.4746,
  );
  LatLng _heatmapLocation = inicialPosition;
  //Coordenadas parroquias
  //final laMatriz = LatLng();

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    //
    final args = ModalRoute.of(context).settings.arguments;
    
    // coordenadasProvider.cargarData(args).then((value) {
    //   print('********************');
    //   print(value);
    //   print('********************');
    // });
    FutureBuilder(
      future: coordenadasProvider.cargarData(args),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        heatmaps: _heatmaps,
        polygons: _poligns,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      SpeedDial(
        marginRight: 40,
      marginBottom: 20,
      animatedIcon: AnimatedIcons.menu_close,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0,
      children: [
        SpeedDialChild(
          label: 'To the lake!',
          child: Icon(Icons.directions_boat),
          onTap:_goToTheLake,
          
        ),
        SpeedDialChild(
          label: 'Add Heatmap',
          child: Icon(Icons.add_box),
          onTap:_addHeatmap,
          
        ),
        SpeedDialChild(
          label: 'Add Polygons',
          child: Icon(Icons.polymer),
          onTap:_addPolygon,
          
        ),
        SpeedDialChild(
          label: 'Home',
          child: Icon(Icons.home),
          onTap: (){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return HomeScreen();
            //     },
            //   ),
            // );
          }
        ),
      ],
      ),
      ],
      ),
      );
      },
    );
  }
  void _addPolygon(){
    setState(() {
      _poligns.add(
        Polygon(
          polygonId:PolygonId('Prueba'),
          fillColor: Colors.green[50],
          strokeWidth: 6,
          strokeColor: Colors.red,
          points:_creaPoligono(),
          ),
      );
    });
  }
  void _addHeatmap(){
    setState(() {
      _heatmaps.add(
        Heatmap(
          heatmapId: HeatmapId(_heatmapLocation.toString()),
          points: _createPoints(_heatmapLocation),
          radius: 20,
          visible: true,
          gradient:  HeatmapGradient(
            colors: <Color>[Colors.green, Colors.red], 
            startPoints: <double>[0.2, 0.8]
          )
        )
      );
    });
  }
  List<LatLng> _creaPoligono(){
    final List<LatLng>points=[];
    for (var i = 0; i < coordenadas.length; i++) {
      points.add(coordenadas[i]);
    }
    return points;
  }
  //heatmap generation helper functions
  List<WeightedLatLng> _createPoints(LatLng location) {
  LatLng _coordenada1 = LatLng(-0.918592, -78.633133);
  LatLng _coordenada2 = LatLng(-0.919142, -78.632288);
  LatLng _coordenada3 = LatLng(-0.918045, -78.633328);

    final List<WeightedLatLng> points = <WeightedLatLng>[];
    //Can create multiple points here
    for (var i = 0; i < coordenadas.length; i++) {
      points.add(_createWeightedLatLng(coordenadas[i].latitude,coordenadas[i].longitude, 1));
    }
    points.add(_createWeightedLatLng(location.latitude,location.longitude, 1));
    points.add(_createWeightedLatLng(_coordenada1.latitude,_coordenada1.longitude, 1));
    points.add(_createWeightedLatLng(_coordenada2.latitude,_coordenada2.longitude, 1));
    points.add(_createWeightedLatLng(_coordenada3.latitude,_coordenada3.longitude, 1));
    
    return points;
  }

  WeightedLatLng _createWeightedLatLng(double lat, double lng, int weight) {
    return WeightedLatLng(point: LatLng(lat, lng), intensity: weight);
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  
}