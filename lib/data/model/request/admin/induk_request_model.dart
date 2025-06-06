import 'dart:convert';

class IndukRequestModel {
    final String? noRing;
    final DateTime? tanggalLahir;
    final String? jenisKelamin;
    final String? jenisKenari;
    final dynamic keterangan;
    final dynamic gambarInduk;

    IndukRequestModel({
        this.noRing,
        this.tanggalLahir,
        this.jenisKelamin,
        this.jenisKenari,
        this.keterangan,
        this.gambarInduk,
    });

    factory IndukRequestModel.fromJson(String str) => IndukRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory IndukRequestModel.fromMap(Map<String, dynamic> json) => IndukRequestModel(
        noRing: json["no_ring"],
        tanggalLahir: json["tanggal_lahir"] == null ? null : DateTime.parse(json["tanggal_lahir"]),
        jenisKelamin: json["jenis_kelamin"],
        jenisKenari: json["jenis_kenari"],
        keterangan: json["keterangan"],
        gambarInduk: json["gambar_induk"],
    );

    Map<String, dynamic> toMap() => {
        "no_ring": noRing,
        "tanggal_lahir": "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
        "jenis_kelamin": jenisKelamin,
        "jenis_kenari": jenisKenari,
        "keterangan": keterangan,
        "gambar_induk": gambarInduk,
    };
}