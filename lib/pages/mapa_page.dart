import 'package:covid/main.dart';
import 'package:covid/models/coordenadas_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';
import 'dart:async';
class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  //CoordenadasProvider data = CoordenadasProvider();
  Completer<GoogleMapController> _controller = Completer();
  final Set<Heatmap> _heatmaps = {};
  final Set<Polygon> _poligns = {};
  bool _flag = false;
  String ruta;
  LatLng posicionInicial;
  double acercamiento;
  LatLng _heatmapLocation = LatLng(37.42796133580664, -122.085749655962);
  @override
  Widget build(BuildContext context) {
    //Argumentos recibidos
    print('VUELVE A INICIAR');
    if(!_flag){
      print('Bandera Verdadera');
      final List<dynamic> args= ModalRoute.of(context).settings.arguments;
      ruta=args[0];
      posicionInicial=args[1];
      acercamiento = args[2];
      _flag = true;
    } else{
      print('Bandera Falsa');
      print(ruta);
      print(posicionInicial);
      print(acercamiento);
    }
    //
    //Posici'on de la c'amara
    final CameraPosition _posicionInicial = CameraPosition(
      target: posicionInicial,
      zoom: acercamiento,
      );
    //

    return FutureBuilder <List<LatLng>>(
      future: coordenadasProvider.cargarData(ruta),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        print('******************');
        print(ruta);
        //print(snapshot.data);
        print('******************');
        List<LatLng> coordenadas = snapshot.data[0];
        
        return Scaffold(
          body: Stack(
            children: <Widget>[
              _crearMapa(_posicionInicial),
              _crearBotonesUrbanos(context, coordenadas,_posicionInicial),
              _crearBotonesRurales(context, coordenadas,_posicionInicial),
              
            ],
          ),
        );
      },
    );
  }

  Widget _crearBotonesUrbanos(BuildContext context, List<LatLng> coordenadas,CameraPosition _posicionInicial){
    return SpeedDial(
        marginRight: 40,
      marginBottom: 20,
      animatedIcon: AnimatedIcons.menu_close,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0,
      children: [
        SpeedDialChild(
          label: 'Add Heatmap',
          child: Icon(Icons.add_box),
          onTap:(){
              _addHeatmap(coordenadas);
            },
            ),
        SpeedDialChild(
          label: 'Add Polygons',
          child: Icon(Icons.polymer),
          onTap:(){
            _addPolygon(coordenadas);
          },
          
        ),
        SpeedDialChild(
          label: 'Alaquez',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='alaquez';
              posicionInicial=LatLng(-0.865606, -78.596436);
              acercamiento =11;
              _goTo(_posicionInicial);
              _addPolygon(coordenadas);
            });
          },
          
        ),
        SpeedDialChild(
          label: 'Belisario Quevedo',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='belisario_quevedo';
              posicionInicial=LatLng(-0.972392, -78.560126);
              acercamiento =12;
              _goTo(_posicionInicial);
              _addPolygon(coordenadas);
            });
          },
        ),
        SpeedDialChild(
          label: 'Eloy Alfaro',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='eloy_alfaro';
              posicionInicial=LatLng(-0.932479,-78.639883);
              acercamiento =12;
              _goTo(_posicionInicial);
              _addPolygon(coordenadas);
            });
          },
        ),
        SpeedDialChild(
          label: 'Home',
          child: Icon(Icons.home),
          onTap: (){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       coordenadas=null;
            //       return HomeScreen();
            //     },
            //   ),
            // );
          }
        ),
      ],
      );
  }

  Widget _crearBotonesRurales(BuildContext context, List<LatLng> coordenadas,CameraPosition _posicionInicial){
    return SpeedDial(
      marginRight: 100,
      marginBottom: 20,
      animatedIcon: AnimatedIcons.menu_close,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0,
      children: [
        SpeedDialChild(
          label: 'Alaquez',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='alaquez';
              posicionInicial=LatLng(-0.865606, -78.596436);
              acercamiento =11;
              _goTo(_posicionInicial);
              _addPolygon(coordenadas);
            });
          },
          
        ),
        SpeedDialChild(
          label: 'Belisario Quevedo',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='belisario_quevedo';
              posicionInicial=LatLng(-0.972392, -78.560126);
              acercamiento =12;
              _goTo(_posicionInicial);
              _addPolygon(coordenadas);
            });
          },
        ),
        SpeedDialChild(
          label: 'Guaytacama',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='guaytacama';
              posicionInicial=LatLng(-0.823045, -78.641124);
              acercamiento =13;
              _goTo(_posicionInicial);
              _addPolygon(coordenadas);
            });
          },
        ),
        SpeedDialChild(
          label: 'Joseguango Bajo',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='joseguango';
              posicionInicial=LatLng(-0.821290, -78.602200);
              acercamiento =13;
              _goTo(_posicionInicial);
              _addPolygon(coordenadas);
            });
          },
        ),
        SpeedDialChild(
          label: 'Mulaló',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='mulalo';
              posicionInicial=LatLng(-0.731473, -78.517155);
              acercamiento =12;
              _goTo(_posicionInicial);
              _addPolygon(coordenadas);
            });
          },
        ),
        SpeedDialChild(
          label: 'Poaló',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='poalo';
              posicionInicial=LatLng(-0.883526, -78.674524);
              acercamiento =11.5;
              _goTo(_posicionInicial);
              _addPolygon(coordenadas);
            });
          },
        ),
        SpeedDialChild(
          label: 'Pastocalle',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='pastocalle';
              posicionInicial=LatLng(-0.724883, -78.634317);
              acercamiento =11;
              _goTo(_posicionInicial);
              _addPolygon(coordenadas);
            });
          },
        ),
        SpeedDialChild(
          label: 'Tanicuchí',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='tanicuchi';
              posicionInicial=LatLng(-0.787643, -78.645416);
              acercamiento =12;
              _goTo(_posicionInicial);
              _addPolygon(coordenadas);
            });
          },
        ),
        SpeedDialChild(
          label: 'Toacaso',
          child: Icon(Icons.zoom_out_map),
          onTap:(){
            setState(() {
              ruta='toacaso';
              posicionInicial=LatLng(-0.707602, -78.758607);
              acercamiento =11;
              _addPolygon(coordenadas);
              _goTo(_posicionInicial);
              
            });
          },
        ),
        
      ],
      );
  }


  Widget _crearMapa(CameraPosition posicionInicial){
    return GoogleMap(
      initialCameraPosition: posicionInicial,
        heatmaps: _heatmaps,
        polygons: _poligns,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

    );
  }

  _addHeatmap(List<LatLng> coordenadas){
    setState(() {
      _heatmaps.add(
        Heatmap(
          heatmapId: HeatmapId(_heatmapLocation.toString()),
          points: _createPoints(coordenadas),
          radius: 20,
          visible: true,
          gradient:  HeatmapGradient(
            colors: <Color>[Colors.green, Colors.red], startPoints: <double>[0.2, 0.8]
          )
        )
      );
    });
  }

  //Crear Poligonos
    _addPolygon(List<LatLng> coordenadas){
    setState(() {
      _poligns.add(
        Polygon(
          polygonId:PolygonId(coordenadas[1].toString()),
          fillColor: Colors.green[50],
          strokeWidth: 6,
          strokeColor: Colors.red,
          points:coordenadas,
          ),
      );
    });
  }

  //Puntos del poligono
  List<LatLng> _creaPoligono(List<LatLng> coordenadas){
    final List<LatLng>points=[];
    for (var i = 0; i < coordenadas.length; i++) {
      points.add(coordenadas[i]);
    }
    return points;
  }

  //heatmap generation helper functions
  List<WeightedLatLng> _createPoints(List<LatLng> coordenadas) {
    final List<WeightedLatLng> points = <WeightedLatLng>[];
    //Can create multiple points here
    for (var i = 0; i < coordenadas.length; i++) {
      points.add(_createWeightedLatLng(coordenadas[i].latitude,coordenadas[i].longitude, 1));
    }
    
    return points;
  }

  WeightedLatLng _createWeightedLatLng(double lat, double lng, int weight) {
    return WeightedLatLng(point: LatLng(lat, lng), intensity: weight);
  }

  Future<void> _goTo(CameraPosition _posicionInicial) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_posicionInicial));
  }


}