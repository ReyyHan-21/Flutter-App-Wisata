import 'package:flutter_app/data/models/request/login_request_model.dart';
import 'package:flutter_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_app/core/constants/variables.dart';
import '../models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';


class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(LoginRequestModel data) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
    );

    if (response.statusCode == 200) {
      return Right('Logout success');
    } else { 
      return Left(response.body);
    }
  }
}