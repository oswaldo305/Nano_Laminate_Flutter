import 'dart:convert';

Archive archiveFromJson(String str) => Archive.fromJson(json.decode(str));

String archiveToJson(Archive data) => json.encode(data.toJson());

class Archive {
    String ? id;
    String nombre;

    Archive({
        required this.nombre,
    });

    factory Archive.fromJson(Map<String, dynamic> json) => Archive(
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
    };
}