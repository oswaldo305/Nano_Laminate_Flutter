import 'dart:convert';

ImageUser imageUserFromJson(String str) => ImageUser.fromJson(json.decode(str));

String imageUserToJson(ImageUser data) => json.encode(data.toJson());

class ImageUser {
    String? id;
    String nombre;
    String idArchive;
    String? path;
    bool status;

    ImageUser({
        this.id,
        required this.nombre,
        required this.idArchive,
        this.path,
        required this.status
    });

    factory ImageUser.fromJson(Map<String, dynamic> json) => ImageUser(
        id: json["id"],
        nombre: json["nombre"],
        idArchive: json["idArchive"],
        path: json["path"],
        status: json["status"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "idArchive" : idArchive,
        "path": path,
        "status" : status
    };
}