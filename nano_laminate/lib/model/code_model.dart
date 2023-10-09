import 'dart:convert';

Code codeFromJson(String str) => Code.fromJson(json.decode(str));

String codeToJson(Code data) => json.encode(data.toJson());

class Code {
    String? id;
    int puntos;
    bool status;

    Code({
        this.id,
        required this.puntos,
        required this.status,
    });

    factory Code.fromJson(Map<String, dynamic> json) => Code(
        id: json["id"],
        puntos: json["puntos"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "puntos": puntos,
        "status": status,
    };

    Map<String, dynamic> toDoc() => {
      "puntos" : puntos,
      "status" : status
    };

} 