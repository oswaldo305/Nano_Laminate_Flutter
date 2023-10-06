import 'dart:convert';

Archive archiveFromJson(String str) => Archive.fromJson(json.decode(str));

String archiveToJson(Archive data) => json.encode(data.toJson());

class Archive {
    String ? id;
    String nombre;
    bool status;

    Archive({
        required this.nombre,
        required this.status
    });

    factory Archive.fromJson(Map<String, dynamic> json) => Archive(
        nombre: json["nombre"],
        status: json["status"]
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "status" : status
    };
}