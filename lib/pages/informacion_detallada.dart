import 'package:covid/models/datos_model.dart';
import 'package:covid/models/datos_provider.dart';
import 'package:flutter/material.dart';
class InformacionDetallada extends StatefulWidget {
  @override
  _InformacionDetalladaState createState() => _InformacionDetalladaState();
}

class _InformacionDetalladaState extends State<InformacionDetallada> {
  DatosProvider datosProvider = new DatosProvider();
  
  @override
  Widget build(BuildContext context) {
    String parroquia = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Casos en $parroquia'),
        
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.pushNamed(context, 'upload');
        }, 
        label: Icon(Icons.add),
        backgroundColor: Color(0xFF4056C6),
        ),
      body: Container(
        child: _listado(parroquia),
      ),
    );
  }

  Widget _listado(String parroquia){
    return FutureBuilder(
      future: datosProvider.cargarDato(parroquia),
      builder: (BuildContext context, AsyncSnapshot <List<DatosModel>> snapshot) {
        if(snapshot.hasData){
          final datos = snapshot.data;
          return ListView.builder(
            itemCount: datos.length,
            itemBuilder: (context, i)=>_crearItem(datos[i],parroquia)
            );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(DatosModel datos,String parroquia ){
    return SingleChildScrollView(
      child: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Actualizado el: ${datos.fecha}'),
              ),
              FlatButton(
                onPressed:(){
                  _detalles(datos,parroquia);
                }, 
                child: Text('Ver',style: TextStyle(color:Colors.white),),
              color: Theme.of(context).primaryColor,
              
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _detalles(DatosModel datos,String parroquia) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Día: ${datos.fecha}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('La información aquí detallada corresponden a los datos oficiales del COE cantonal'),
                Text('Corresponde a $parroquia'),
                Text('Confirmados: ${datos.confirmados}'),
                Text('Fallecidos: ${datos.fallecidos}'),
                Text('Recuperados: ${datos.recuperados}'),
                Text('Aislamiento: ${datos.aislamiento}'),
                Text('Descartados: ${datos.descartados}'),
                
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed:(){
                Navigator.of(context).pop();
              }, 
              child: Text('Volver',
              style: TextStyle(color:Colors.white),),
              color: Theme.of(context).primaryColor,
              ),
          ],
        );
      } 
      );
  }

}