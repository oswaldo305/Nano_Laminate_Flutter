import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    String? id;
    int puntos;

    Usuario({
        this.id,
        required this.puntos,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        puntos: json["puntos"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "puntos": puntos,
    };

    Map<String, dynamic> toDoc() => {
      "puntos" : puntos
    };

}