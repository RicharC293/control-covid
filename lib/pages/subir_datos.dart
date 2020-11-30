import 'package:covid/models/datos_model.dart';
import 'package:covid/models/datos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class SubirDatos extends StatefulWidget {
  @override
  _SubirDatosState createState() => _SubirDatosState();
}

class _SubirDatosState extends State<SubirDatos> {
  final datoProvider = new DatosProvider();
  DatosModel datos = new DatosModel();
  final formKey = GlobalKey<FormState>();
  String parroquia= 'Latacunga';
  @override
  Widget build(BuildContext context) {
    
    var now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String fecha = date.toString().substring(0,10);
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Información'),
        backgroundColor: Color(0xFF4056C6),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _seleccionarParroquia(),
                Divider(height:5),
                _agregarFecha(fecha),
                Divider(height: 5,),
                _agregarConfirmados(),
                Divider(height: 5,),
                _agregarSospechosos(),
                Divider(height: 5,),
                _agregarDescartados(),
                Divider(height: 5,),
                _agregarRecuperados(),
                Divider(height: 5,),
                _agregarFallecidos(),
                Divider(height: 5,),
                _agregarAislamiento(),
                Divider(),
                _subir(),
              ],
            )
            ),
        ),
      ),
    );
  }

  Widget _seleccionarParroquia(){
    
    return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                      value: parroquia,
                      items: [
                        'Latacunga',
                        'La Matríz',
                        'Eloy Alfaro',
                        'Ignacio Flores',
                        'Juan Montalvo',
                        'San Buenaventura',
                        'Toacaso',
                        'Pastocalle',
                        'Mulaló',
                        'Tanicuchí',
                        'Guaytacama',
                        'Aláquez',
                        'Poaló',
                        'Once de Noviembre',
                        'Belisario Quevedo',
                        'Joseguango Bajo'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          parroquia = value;
                        });
                        print(value);
                        
                      },
                    ),
                  ),
                ],
              ),
            );
  }

  Widget _agregarFecha(String fecha){
    return TextFormField(
      initialValue: fecha,
      enabled: false,
      decoration: InputDecoration(
        labelText: 'Fecha de registro',
        border: const OutlineInputBorder(),
        icon: Icon(Icons.date_range),
        fillColor: Colors.black,
      ),
      onSaved: (String value)=>datos.fecha=value,
    );
  }

  Widget _agregarConfirmados(){
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      initialValue: datos.confirmados.toString(),
      decoration: InputDecoration(
        labelText:'Número de casos confirmados',
        border: const OutlineInputBorder(),
        icon: Icon(Icons.local_hospital),
        ),
        onSaved: (String value)=>datos.confirmados=int.parse(value),
    );
  }

  Widget _agregarSospechosos(){
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      initialValue: datos.sospechosos.toString(),
      decoration: InputDecoration(
        labelText:'Número de casos sospechosos',
        border: const OutlineInputBorder(),
        icon: Icon(Icons.warning)
        ),
        onSaved: (String value)=>datos.sospechosos=int.parse(value),
    );
  }

  Widget _agregarDescartados(){
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      initialValue: datos.descartados.toString(),
      decoration: InputDecoration(
        labelText:'Número de casos descartados',
        border: const OutlineInputBorder(),
        icon: Icon(Icons.block)
        ),
      onSaved: (String value)=>datos.descartados=int.parse(value),
    );
  }

  Widget _agregarRecuperados(){
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      initialValue: datos.recuperados.toString(),
      decoration: InputDecoration(
        labelText:'Número de casos recuperados',
        border: const OutlineInputBorder(),
        icon: Icon(Icons.mood)
        ),
      onSaved: (String value)=>datos.recuperados=int.parse(value),
    );
  }

  Widget _agregarFallecidos(){
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      initialValue: datos.fallecidos.toString(),
      decoration: InputDecoration(
        labelText:'Número de casos fallecidos',
        border: const OutlineInputBorder(),
        icon: Icon(Icons.mood_bad)
        ),
      onSaved: (String value)=>datos.fallecidos=int.parse(value),
    );
  }

  Widget _agregarAislamiento(){
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      initialValue: datos.aislamiento.toString(),
      decoration: InputDecoration(
        labelText:'Número de casos en aislamiento',
        border: const OutlineInputBorder(),
        icon: Icon(Icons.block)
        ),
      onSaved: (String value)=>datos.aislamiento=int.parse(value),
    );
  }

  Widget _subir(){
    return RaisedButton.icon(
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
      color: Color(0xFF4056C6),
      label: Text('Actualizar',style:TextStyle(color:Colors.white,fontSize: 20.0),),
      icon: Icon(Icons.update,color: Colors.white,),
      onPressed: (){
        _alerta();
      },
      );
  }

  Future<void> _alerta() async {
    formKey.currentState.save();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Alerta'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Verifique que la información sea correcta, una vez aceptada no podrá ser modificada ni eliminada'),
                Text('Información correspondiente a $parroquia'),
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
                _submit();
                Navigator.of(context).pop();
              }, 
              child: Text('Aceptar', 
              style: TextStyle(color:Colors.white),),
              color: Theme.of(context).primaryColor,
              ),
            FlatButton(
              onPressed:(){
                Navigator.pop(context);
              }, 
              child: Text('Cancelar',
              style: TextStyle(color:Colors.white),),
              color: Theme.of(context).primaryColor,
              ),
          ],
        );
      } 
      );
  }

  void _submit(){
      print('Guardando dato');
      datoProvider.crearDato(datos, parroquia);
    Navigator.of(context).pop();
  }
}