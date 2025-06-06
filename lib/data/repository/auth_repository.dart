import 'dart:convert';

import 'package:canary_template/data/model/request/auth/loginRequestModel.dart';
import 'package:canary_template/data/model/request/auth/registerRequestModel.dart';
import 'package:canary_template/data/model/response/auth_response_model.dart';
import 'package:canary_template/services/services_http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final ServicesHttpClient _servicehttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._servicehttpClient);

  Future<Either<String, AuthResponseModel>> login(LoginRequestModel requestModel) async {
    try {
      final response = await _servicehttpClient.post(
        "Login",
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final loginResponse = AuthResponseModel.fromMap(jsonResponse);
        await secureStorage.write(
          key: "AuthToken",
          value: loginResponse.user?.token,
        );
        await secureStorage.write(
          key: "UserId",
          value: loginResponse.user?.id.toString(),
        );
        return Right(loginResponse);
      } else {
        return Left(jsonResponse['error'] ?? 'Login failed');
      }
    } catch (e) {
      return Left("An error occurred while logging in: $e");
    }
  }

  Future<Either<String, String>> register(RegisterRequestModel requestModel) async {
    try {
      final response = await _servicehttpClient.post(
        "Register",
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      final registerResponse = jsonResponse['message'] as String;
      if (response.statusCode == 201) {
        return Right(registerResponse);
      } else {
        return Left(jsonResponse['error'] ?? 'Registration failed');
      }
    } catch (e) {
      return Left("An error occurred while registering: $e");
    }
  }
}