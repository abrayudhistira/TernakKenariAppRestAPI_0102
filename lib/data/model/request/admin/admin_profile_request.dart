import 'dart:convert';

class AdminProfilRequest {
    final String? message;
    final int? statusCode;
    final Data? data;

    AdminProfilRequest({
        this.message,
        this.statusCode,
        this.data,
    });

    factory AdminProfilRequest.fromJson(String str) => AdminProfilRequest.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AdminProfilRequest.fromMap(Map<String, dynamic> json) => AdminProfilRequest(
        message: json["message"],
        statusCode: json["status_code"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "status_code": statusCode,
        "data": data?.toMap(),
    };
}

class Data {
    final int? id;
    final String? name;

    Data({
        this.id,
        this.name,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}