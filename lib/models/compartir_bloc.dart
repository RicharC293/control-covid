//Pasos patron bloc
//1. Imports
//2. Lista 
//3. Stream Controller
//4. Stream Sink
//5. Constructor añadir datos, escuchar cambios
//6. Funciones Principales
//7. Dispose

import 'dart:async';
import 'package:covid/models/compartir.dart';

class CompartirBloc {

  List<Compartir> _compartirList = [
    Compartir('la_matriz')
  ];

  //Stream controller
  final _compartirListStreamController = StreamController<List<Compartir>>();
  
  //Getter streams y sinks
  Stream<List<Compartir>> get compartirListStream => _compartirListStreamController.stream;
  StreamSink<List<Compartir>> get compartirListSink => _compartirListStreamController.sink;

  //Constructor
  CompartirBloc(){
    _compartirListStreamController.add(_compartirList);
  }

  //Funciones principales de ser necesario


  //Dispose cerrar stream
  void dispose(){
    _compartirListStreamController.close();
  }


}