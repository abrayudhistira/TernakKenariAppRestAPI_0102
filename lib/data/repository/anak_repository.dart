import 'dart:convert';

import 'package:canary_template/data/model/request/admin/anak_request_model.dart';
import 'package:canary_template/data/model/response/get_all_anak_response.dart';
import 'package:canary_template/services/services_http_client.dart';
import 'package:dartz/dartz.dart';

class AnakRepository {
  final ServicesHttpClient _serviceHttpClient;

  AnakRepository(this._serviceHttpClient);

  Future<Either<String, GetAnakById>> addAnak(
      AnakRequestModel requestModel) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "admin/anak",
        requestModel.toMap(),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = GetAnakById.fromJson(jsonResponse);
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while adding profile: $e");
    }
  }

  Future<Either<String, GetAllAnakModel>> getAllAnak() async {
    try {
      final response = await _serviceHttpClient.get("admin/anak");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = GetAllAnakModel.fromJson(jsonResponse);
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while get all anak: $e");
    }
  }
}