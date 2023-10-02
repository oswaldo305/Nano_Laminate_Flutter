import 'dart:convert';

ImageUser imageUserFromJson(String str) => ImageUser.fromJson(json.decode(str));

String imageUserToJson(ImageUser data) => json.encode(data.toJson());

class ImageUser {
    int id;
    String nombre;
    String idArchive;
    String? path;
    double precio;

    ImageUser({
        required this.id,
        required this.nombre,
        required this.idArchive,
        this.path,
        required this.precio,
    });

    factory ImageUser.fromJson(Map<String, dynamic> json) => ImageUser(
        id: json["id"],
        nombre: json["nombre"],
        idArchive: json["idArchive"],
        path: json["path"],
        precio: json["precio"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "idArchive" : idArchive,
        "path": path,
        "precio": precio,
    };
}