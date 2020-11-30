import 'dart:convert';
import 'package:covid/models/parroquia_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';

class _CoordenadasProvider{
  //static LatLng inicialPosition = LatLng(-0.933770, -78.610645);
  //String parroquiaInicial = 'la_matriz';
  List<LatLng> coordenadas =[];
  final List<LatLng>points=[];
  List datos=[];
  Future <List<dynamic>>cargarData(String parroquiaInicial)async{
    // List<String> parroquias = ['alaquez','belisario_quevedo','eloy_alfaro','guaytacama','ignacio_flores',
    // 'joseguango','juan_montalvo','la_matriz','mulalo','once_noviembre','pastocalle','poalo','san_buenaventura',
    // 'tanicuchi','toacaso'];
    // for (var i = 0; i < parroquias.length; i++) {
      
    //   final resp = await rootBundle.loadString('assets/json/${parroquias[i]}.json');
    //   Map dataMap = json.decode(resp);
    //   Parroquia parroquia = new Parroquia.fromJson(dataMap);
    //   List<List<double>> coords = parroquia.coordinates;
    //   for (var item in coords) {
    //   coordenadas.add(LatLng(item[1],item[0]));  
    // }
    // }
    final resp = await rootBundle.loadString('assets/json/$parroquiaInicial.json');
    Map dataMap = json.decode(resp);
    Parroquia parroquia = new Parroquia.fromJson(dataMap);
    List<List<double>> coords = parroquia.coordinates;
    List<double> posMarker = parroquia.ubicacion;
    String archivo = parroquia.nombre;
    double zoom = parroquia.zoom;
    String nombre = parroquia.type;
    coordenadas=[];
    for (var item in coords) {
      coordenadas.add(LatLng(item[1],item[0]));  
    }
  datos = [coordenadas,posMarker,archivo,zoom,nombre];
  return datos;
  }

}
final coordenadasProvider = _CoordenadasProvider();

