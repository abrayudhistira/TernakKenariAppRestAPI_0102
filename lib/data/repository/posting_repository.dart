import 'dart:convert';
import 'dart:developer';

import 'package:canary_template/data/model/request/admin/posting_jual_request_model.dart';
import 'package:canary_template/data/model/response/burung_tersedia_semua_model.dart';
import 'package:canary_template/data/model/response/get_all_burung_response_model.dart';
import 'package:canary_template/services/services_http_client.dart';
import 'package:dartz/dartz.dart';

class PostingRepository {
  final ServicesHttpClient _serviceHttpClient;

  PostingRepository(this._serviceHttpClient);

  Future<Either<String, BurungSemuaTersediabyIdModel>> addPostBurung(
      PostingJualRequestModel requestModel) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        'admin/posting-jual',
        requestModel.toMap(),
      );

      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        final profileResponse =
            BurungSemuaTersediabyIdModel.fromJson(jsonResponse);
        log("Add Burung successful: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Add burung failed: ${jsonResponse['message']}");
        return Left(jsonResponse['message'] ?? "Add burung failed");
      }
    } catch (e) {
      log("Error in Add burung : $e");
      return Left("An error occurred while post burung: $e");
    }
  }

  Future<Either<String, GetAllBurungModel>> getAllBurung() async {
    try {
      final response = await _serviceHttpClient.get("admin/burung-semua");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final getAllBurung = GetAllBurungModel.fromMap(jsonResponse);
        return Right(getAllBurung);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? "Get All burung failed");
      }
    } catch (e) {
      return Left("An error occurred while getting all burung: $e");
    }
  }
}