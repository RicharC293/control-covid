import 'package:covid/models/datos_model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Sample time series data type.
/// Data class to visualize.
class _SalesData {
  final List<int> year;
  final int sales;

  _SalesData(this.year, this.sales);
  // Returns Jan.1st of that year as date.
  DateTime get date => DateTime(this.year[0], this.year[1], this.year[2]);
}

class Grafica extends StatelessWidget {
  final List<DatosModel> datos;
  Grafica({@required this.datos});

  List<_SalesData> data(){
    List<int> valor = [];
    List<List<int>> dia = [];
    datos.forEach((e){
        valor.add(e.confirmados);
        String _fecha=e.fecha;
        //_fecha=_fecha.substring(8);
        dia.add([int.parse(_fecha.substring(0,4)),int.parse(_fecha.substring(5,7)),int.parse(_fecha.substring(8))]);
    });
    return [
    for (int i = 1; i < datos.length+1; ++i)
      _SalesData(dia[datos.length-i], valor[datos.length-i]),
    ];
    // datos.map((e){
    //   for (var i = 0; i < datos.length; i++) {
    //     lista.add(_SalesData(i,e.confirmados));
    //     print(e.confirmados);
    //   }
    // });
    //print(lista);
    //return lista;
  }
    // Chart configs.
  final bool _animate = true;
  final bool _defaultInteractions = true;
  final bool _includeArea = true;
  final bool _includePoints = true;
  final bool _stacked = true;
  //final charts.BehaviorPosition _titlePosition = charts.BehaviorPosition.bottom;
  final charts.BehaviorPosition _legendPosition = charts.BehaviorPosition.bottom;
  

  @override
  Widget build(BuildContext context) {
  

    return Container(
          height: 300,
          child: charts.TimeSeriesChart(
            /*seriesList=*/ [
              charts.Series<_SalesData, DateTime>(
                id: 'Contagiados',
                colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                domainFn: (_SalesData sales, _) => sales.date,
                measureFn: (_SalesData sales, _) => sales.sales,
                data: data(),
              ),
            ],
            defaultInteractions: this._defaultInteractions,
            defaultRenderer: charts.LineRendererConfig(
              includePoints: this._includePoints,
              includeArea: this._includeArea,
              stacked: this._stacked,
            ),
            animate: this._animate,
            behaviors: [
              // Add title.
              // charts.ChartTitle('Dummy sales time series',
              //     behaviorPosition: _titlePosition),
              // Add legend.
              charts.SeriesLegend(position: _legendPosition),
              // Highlight X and Y value of selected point.
              charts.LinePointHighlighter(
                showHorizontalFollowLine:
                    charts.LinePointHighlighterFollowLineType.all,
                showVerticalFollowLine:
                    charts.LinePointHighlighterFollowLineType.nearest,
              ),
            ],
          ),
        );
  }

}