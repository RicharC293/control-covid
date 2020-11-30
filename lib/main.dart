
import 'dart:io' show Platform;//Libreria para determinar IOS o Android
import 'package:covid/pages/grafica_detalle.dart';
import 'package:covid/pages/home_page.dart';
import 'package:flutter/services.dart';
import 'package:covid/constant.dart';
import 'package:covid/pages/informacion_detallada.dart';
import 'package:covid/pages/subir_datos.dart';
import 'package:covid/pages/ubicacion.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      //Cambiar los colores del ICONOs
    if(Platform.isAndroid){SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent
    ));
    }else if(Platform.isIOS){SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white
    ));
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: Color(0xFF4056C6),
          fontFamily: "Poppins",
          textTheme: TextTheme(
            bodyText2: TextStyle(color: kBodyTextColor),
          )),
      //home: HomeScreen(),
      initialRoute: 'home',
      routes: {
        'home'        : (BuildContext context)  => HomeScreen(),
        'mapa'        : (BuildContext context)  => MapaUbicacion(),
        'upload'      : (BuildContext context)  => SubirDatos(),
        'informacion' : (BuildContext context)  => InformacionDetallada(),
        //'grafica'     : (BuildContext context)   => SimpleTimeSeriesChart(),
      },
    );
  }
}
/*
class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final datosProvider = new DatosProvider();
  final controller = ScrollController();
  double offset = 0;
  String parroquia= 'La Matríz';
  LatLng posicion;
  double zoom;
  String parroquia1;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                MyHeader(
                  image: "assets/icons/Drcorona.svg",
                  textTitle: 'LATACUNGA',
                  textTop: "Protégete del",
                  textBottom: "coronavirus",
                  offset: offset,
                ),
                Container(
                  padding: EdgeInsets.only(top:size.height*0.06,right: size.width*0.01),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return InfoScreen();
                          },
                        ),
                      );
                    },
                    child: Icon(Icons.info,color:Colors.white,size:30.0 ,),
                  ),
                ),
              ],
            ),

            
            RichText(
              text: TextSpan(
              children: [
                TextSpan(
                  text: "Parroquia",
                  style: kTitleTextstyle,
                ),
              ]
            ),
            ),
            SizedBox(height: 10.0,),
            Container(
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
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      FutureBuilder(
                        future: datosProvider.cargarDato(),
                        builder: (BuildContext context, AsyncSnapshot<List<DatosModel>> snapshot) {
                          
                          if (snapshot.hasData){
                            final datos= snapshot.data;
                            final contador = datos.length;
                            //print(snapshot.data);
                          return RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Casos confirmados\n",
                                  style: kTitleTextstyle,
                                ),
                                TextSpan(
                                  text: "Actualizado el  ${datos[contador-1].fecha}",
                                  style: TextStyle(
                                    color: kTextLightColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                          } else{
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                      
                      Spacer(),
                      GestureDetector(
                        child: Text(
                          "Más detalles",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, 'informacion');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FutureBuilder(
                        future: datosProvider.cargarDato(),                        
                        builder: (BuildContext context, AsyncSnapshot <List<DatosModel>> snapshot) {
                          if(snapshot.hasData){
                            final datos=snapshot.data;
                            final contador = datos.length;
                            return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Counter(
                            color: kInfectedColor,
                            number: datos[contador-1].confirmados,
                            title: "Infectados",
                          ),
                          SizedBox(width: 20.0),
                          Counter(
                            color: kDeathColor,
                            number: datos[contador-1].fallecidos,
                            title: "Fallecidos",
                          ),
                          SizedBox(width: 20.0),
                          Counter(
                            color: kRecovercolor,
                            number: datos[contador-1].recuperados,
                            title: "Recuperados",
                          ),
                        ],
                      );
                          }else{
                            return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Counter(
                            color: kInfectedColor,
                            number: 000,
                            title: "Infectados",
                          ),
                          SizedBox(width: 20.0),
                          Counter(
                            color: kDeathColor,
                            number: 000,
                            title: "Fallecidos",
                          ),
                          SizedBox(width: 20.0),
                          Counter(
                            color: kRecovercolor,
                            number: 000,
                            title: "Recuperados",
                          ),
                        ],
                      );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Crecimiento de contagios",
                        style: kTitleTextstyle,
                      ),
                      //FlatButton(                                              
                        //child: 
                        GestureDetector(
                          child: Text(
                            "Más detalles",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          ),
                          onTap: (){                           
                            Navigator.pushNamed(context, 'grafica');
                          },
                        ),
                    ],
                  ),
                  //Aquí inicia el código de las gráficas
                  
                  
                  //Fin del código de las gráficas  

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Propagación",
                        style: kTitleTextstyle,
                      ),
                      //FlatButton(                                              
                        //child: 
                        GestureDetector(
                          child: Text(
                            "Ver mapa de calor",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          ),
                          onTap: (){
                            print(parroquia);
                            if(parroquia=='La Matríz'){
                              parroquia1='la_matriz';
                              posicion = LatLng(-0.930479,-78.617822);
                              zoom = 15;
                            }
                            if(parroquia=='Eloy Alfaro'){
                              parroquia1='eloy_alfaro';
                              posicion = LatLng(-0.932479,-78.639883);
                              zoom = 12;
                            }
                            if(parroquia=='Ignacio Flores'){
                              parroquia1='ignacio_flores';
                              posicion = LatLng(-0.945051, -78.520286);
                              zoom = 11;
                            }
                            if(parroquia=='Juan Montalvo'){
                              parroquia1='juan_montalvo';
                              posicion = LatLng(-0.911142, -78.510133);
                              zoom = 12;
                            }
                            if(parroquia=='San Buenaventura'){
                              parroquia1='san_buenaventura';
                              posicion = LatLng(-0.886661, -78.560581);
                              zoom = 13;
                            }
                            if(parroquia=='Toacaso'){
                              parroquia1='toacaso';
                              posicion = LatLng(-0.707602, -78.758607);
                              zoom = 11;
                            }
                            if(parroquia=='Pastocalle'){
                              parroquia1='pastocalle';
                              posicion = LatLng(-0.724883, -78.634317);
                              zoom = 11;
                            }
                            if(parroquia=='Mulaló'){
                              parroquia1='mulalo';
                              posicion = LatLng(-0.731473, -78.517155);
                              zoom = 11;
                            }
                            if(parroquia=='Tanicuchí'){
                              parroquia1='tanicuchi';
                              posicion = LatLng(-0.787643, -78.645416);
                              zoom = 12;
                            }
                            if(parroquia=='Guaytacama'){
                              parroquia1='guaytacama';
                              posicion = LatLng(-0.823045, -78.641124);
                              zoom = 13;
                            }
                            if(parroquia=='Aláquez'){
                              parroquia1='alaquez';
                              posicion = LatLng(-0.865606, -78.596436);
                              zoom = 11;
                            }
                            if(parroquia=='Poaló'){
                              parroquia1='poalo';
                              posicion = LatLng(-0.883526, -78.674524);
                              zoom = 11.5;
                            }
                            if(parroquia=='Once de Noviembre'){
                              parroquia1='once_noviembre';
                              posicion = LatLng(-0.909411, -78.673682);
                              zoom = 14;
                            }
                            if(parroquia=='Belisario Quevedo'){
                              parroquia1='belisario_quevedo';
                              posicion = LatLng(-0.972392, -78.560126);
                              zoom = 12;
                            }
                            if(parroquia=='Joseguango Bajo'){
                              parroquia1='joseguango';
                              posicion = LatLng(-0.821290, -78.602200);
                              zoom = 13;
                            }
                            
                            Navigator.pushNamed(context, 'mapa',arguments:[parroquia1,posicion,zoom]);
                            

                          },
                        ),
                        
                        // onPressed: (){
                        //   print(parroquia);
                        // },                         
                      //),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(20),
                    height: 178,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/images/map1.png",
                      fit: BoxFit.cover
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


*/