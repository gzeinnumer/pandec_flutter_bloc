import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pandec_flutter_bloc/model/user_details_response.dart';
import 'package:pandec_flutter_bloc/model/user_response.dart';

class Network {
  final baseUrl = 'https://pandec-bloc.gzeinnumer.com/api';
  Dio dio = Dio();

  Future<UsersResponse> getUsers() async {
    try {
      Response json = await dio.get(
        "$baseUrl/users/all",
      );
      return UsersResponse.fromJson(json.data);
    } catch (e) {
      // throw e;
      return UsersResponse(message: e.toString());
    }
  }

  Future<UsersDetailResponse> getUsersById(int id) async {
    try {
      Response json = await dio.get(
        "$baseUrl/users/find/$id",
      );
      return UsersDetailResponse.fromJson(json.data);
    } catch (e) {
      // throw e;
      return UsersDetailResponse(message: e.toString());
    }
  }

  Future<UsersDetailResponse> getUsersByEmailPass(String email, String password, int id) async {
    try {
      Response json = await dio.get(
        "$baseUrl/users/find/$id",
      );
      return UsersDetailResponse.fromJson(json.data);
    } catch (e) {
      // throw e;
      return UsersDetailResponse(message: e.toString());
    }
  }
}
