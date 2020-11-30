import 'dart:convert';

DatosModel datosModelFromJson(String str) => DatosModel.fromJson(json.decode(str));

String datosModelToJson(DatosModel data) => json.encode(data.toJson());

class DatosModel {
    DatosModel({
        this.fecha,
        this.confirmados=0,
        this.sospechosos=0,
        this.descartados=0,
        this.recuperados=0,
        this.fallecidos=0,
        this.aislamiento=0,
    });

    String fecha;
    int confirmados;
    int sospechosos;
    int descartados;
    int recuperados;
    int fallecidos;
    int aislamiento;

    factory DatosModel.fromJson(Map<String, dynamic> json) => DatosModel(
        fecha: json["fecha"],
        confirmados: json["confirmados"],
        sospechosos: json["sospechosos"],
        descartados: json["descartados"],
        recuperados: json["recuperados"],
        fallecidos: json["fallecidos"],
        aislamiento: json["aislamiento"],
    );

    Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "confirmados": confirmados,
        "sospechosos": sospechosos,
        "descartados": descartados,
        "recuperados": recuperados,
        "fallecidos": fallecidos,
        "aislamiento": aislamiento,
    };
}
