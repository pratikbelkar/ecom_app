import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecom_app/networking/api_endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options
      ..baseUrl = APIEndpoints.BaseUrl
      ..connectTimeout = const Duration(seconds: 50)
      ..receiveTimeout = const Duration(seconds: 50)
      ..headers = {
        'content-Type': 'application/json',
      };
  }
  Future<Response> get(String endPoint,
      {Map<String, dynamic>? queryparameters}) async {
    try {
      // ignore: non_constant_identifier_names
      final Response =
          await _dio.get(endPoint, queryParameters: queryparameters);
      log(
        Response.data.toString(),
      );
      return Response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> post(String endPoint, {dynamic body}) async {
    try {
      // ignore: non_constant_identifier_names
      final Response = await _dio.post(endPoint, data: body);
      log(Response.data.toString());
      return Response;
    } catch (e) {
      return Future.error(e);
    }
  }
}

final dioClientProvider = Provider<DioClient>((ref) => DioClient());
