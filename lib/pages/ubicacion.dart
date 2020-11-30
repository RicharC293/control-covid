import 'dart:async';
import 'dart:collection';

import 'package:covid/main.dart';
import 'package:covid/models/coordenadas_providers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';
class MapaUbicacion extends StatefulWidget {
  @override
  _MapaUbicacionState createState() => _MapaUbicacionState();
}
  bool flag = true;
class _MapaUbicacionState extends State<MapaUbicacion> {
  //CoordenadasProvider data = CoordenadasProvider();
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition camaraInicial;
  String ruta;
  List<LatLng> coordenadas = [];
  static LatLng posicion;
  static double zoom;
  String nombre;
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  
  GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
    _mapController = controller;
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(posicion.toString()),
        position: posicion,
        infoWindow: InfoWindow(title: nombre),
        ));
      _polygons.add(Polygon(
        polygonId: PolygonId(posicion.toString()),
        points: coordenadas,
        strokeColor: Colors.red,
        fillColor: Color.fromRGBO(255, 255, 255, 0.1),

        )
        );
        
    });
    


  }
  // CameraPosition _kLake = CameraPosition(
  //     target: posicion,
  //     zoom: zoom
  //     );

  @override
  Widget build(BuildContext context) {
    print('Entra');
    final List<dynamic> args= ModalRoute.of(context).settings.arguments;
    ruta = args[0];
    print(ruta);
    
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Icon(Icons.center_focus_strong),
        backgroundColor: Color(0xFF4056C6),
        onPressed:(){
          _goTo(camaraInicial);
        },
        ),
      appBar: AppBar(
        title: Text('Mapa de Casos'),
        backgroundColor: Color(0xFF4056C6),
      ),
      body: Container(
        child: constructor(ruta),
      ),
      
    );
  }
  Widget constructor(String ruta){
    //List rutas = ['la_matriz','eloy_alfaro','ignacio_flores'];
    if(ruta!=null){
      return FutureBuilder <List<dynamic>>(
      future: coordenadasProvider.cargarData(ruta),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }else{
          coordenadas=snapshot.data[0];
          posicion=LatLng(snapshot.data[1][0],snapshot.data[1][1]);
          zoom = snapshot.data[3];
          nombre=snapshot.data[4];
          camaraInicial = CameraPosition(
            target: LatLng(snapshot.data[1][0],snapshot.data[1][1]),
            zoom: snapshot.data[3],
            ); 
          return creador(snapshot.data,camaraInicial);
        }
        
      },
    );
    }else{
      return Container(
        child: CircularProgressIndicator(),
      );
    }
  }
  
  Widget creador(List<dynamic>data,CameraPosition camaraInicial){
    return Stack(
      children:[
        crearMapa(camaraInicial),
        
        
      ]
      
    );
  }

  Widget crearMapa(CameraPosition camaraInicial){
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition:camaraInicial,
      markers: _markers,
      polygons: _polygons,
      );
  }

  Future<void> _goTo(CameraPosition camaraInicial) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(camaraInicial));
  }
  

}