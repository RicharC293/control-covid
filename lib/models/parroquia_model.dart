import 'dart:convert';

Parroquia parroquiaFromJson(String str) => Parroquia.fromJson(json.decode(str));

String parroquiaToJson(Parroquia data) => json.encode(data.toJson());

class Parroquia {
    Parroquia({
        this.type,
        this.parroquia,
        this.ubicacion,
        this.nombre,
        this.zoom,
        this.coordinates,
    });

    String type;
    String parroquia;
    List<double> ubicacion;
    String nombre;
    double zoom;
    List<List<double>> coordinates;

    factory Parroquia.fromJson(Map<String, dynamic> json) => Parroquia(
        type: json["type"],
        parroquia: json["parroquia"],
        ubicacion: List<double>.from(json["ubicacion"].map((x) => x.toDouble())),
        nombre: json["nombre"],
        zoom: json["zoom"].toDouble(),
        coordinates: List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "parroquia": parroquia,
        "ubicacion": List<dynamic>.from(ubicacion.map((x) => x)),
        "nombre": nombre,
        "zoom": zoom,
        "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}
