
import 'dart:convert';

import 'package:covid/models/datos_model.dart';
import 'package:http/http.dart' as http;
class DatosProvider{

  final String _url = 'https://mapalatacunga.firebaseio.com';
  
  Future<bool> crearDato(DatosModel datos, String parroquia)async{
    print('Subir');
    String partUrl = parroquia.replaceAll(' ', '%20');
    partUrl = partUrl.replaceAll('á', 'a');
    partUrl = partUrl.replaceAll('í', 'i');
    partUrl = partUrl.replaceAll('ó', 'o');
    final url ='$_url/$partUrl.json';

    final resp = await http.post(url, body:datosModelToJson(datos));

    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future <List<DatosModel>> cargarDato(String parroquia)async{
    print('Consulta');
    String partUrl = parroquia.replaceAll(' ', '%20');
    partUrl = partUrl.replaceAll('á', 'a');
    partUrl = partUrl.replaceAll('í', 'i');
    partUrl = partUrl.replaceAll('ó', 'o');
    final url ='$_url/$partUrl.json';

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<DatosModel> datos = new List();
    if(decodedData==null) return[];
    //print(decodedData);
    decodedData.forEach((id, dat) {
      //print(datos);
      final datoTemp = DatosModel.fromJson(dat);
      datos.add(datoTemp);
    });
    //print(datos);

    return datos ;

  }




}