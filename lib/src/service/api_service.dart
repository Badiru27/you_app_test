import 'dart:io' as Platform;

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:you_app/src/features/auth/data/datasources/auth_local_datasource.dart';

abstract class ApiService {
  //? For making get request to the endpoint
  Future<dynamic> get({
    required String url,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic>? headers,
  });

  //? For making post request to the endpoint
  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String> headers,
    Map<String, dynamic>? queryParameters,
  });

  //? For making patch request to the endpoint
  Future<dynamic> patch({
    required String url,
    required Map<String, dynamic> body,
    required Map<String, String> headers,
  });

  //? For making delete request to the endpoint
  Future<dynamic> delete({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, String> headers,
  });

  //? For making put request to the endpoint
  Future put(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers});

  //? For setting the token to the header
  Future<void> setAuthToken();
}

const androidLocalHost = '10.0.2.2:3344';
const iOSLocalHost = '127.0.0.1:3344';

String localHost() {
  if (Platform.Platform.isAndroid) {
    return androidLocalHost;
  } else {
    return iOSLocalHost;
  }
}

final baseUrl = "http://${localHost()}/api";

class ApiServiceImpl implements ApiService {
  final _log = Logger();
  final Dio _dio;
  final AuthLocalDataSource authLocalDataSource;

  ApiServiceImpl(
    this._dio,
    this.authLocalDataSource,
  ) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.validateStatus = (status) => status! >= 200 && status < 300;
    _log.i('Api constructed and DIO setup register');
  }

  @override
  Future get(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    await setAuthToken();
    _log.i(
        'Making Get Request to $url with the following data \n$queryParameters');
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      _log.i('Response from $url \n${response.data}');
      return response.data;
    } on DioException catch (e) {
      _log.e('Error from $url-- ${e.response}');
      rethrow;
    }
  }

  @override
  Future post(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    await setAuthToken();
    _log.i('Making Post Request to $url with the following data \n$body');
    try {
      final response = await _dio.post(url,
          data: body,
          options: Options(headers: headers),
          queryParameters: queryParameters);
      _log.i('Response from $url \n${response.data}');
      return response.data;
    } on DioException catch (e) {
      _log.e('Error from $url-- ${e.response}');
      rethrow;
    }
  }

  @override
  Future put(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    _log.i('Making Put Request to $url with the following data \n$body');
    try {
      await setAuthToken();
      final response =
          await _dio.put(url, data: body, options: Options(headers: headers));

      _log.i('Response from $url \n${response.data}');
      return response.data;
    } on DioException catch (e) {
      _log.e('Error from $url-- ${e.response}');
      rethrow;
    }
  }

  @override
  Future delete(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    await setAuthToken();
    _log.i('Making Delete Request to $url.');
    try {
      final response = await _dio.delete(url,
          queryParameters: queryParameters, options: Options(headers: headers));
      _log.i('Response from $url \n${response.data}');
      return response.data;
    } on DioException catch (error) {
      _log.e('Error from $url-- ${error.toString()}');
      rethrow;
    }
  }

  @override
  Future patch(
      {required String url,
      required Map<String, dynamic> body,
      required Map<String, String> headers}) {
    throw UnimplementedError();
  }

  @override
  Future<void> setAuthToken() async {
    final token = await authLocalDataSource.getToken();
    if (token == null) {
      _dio.options.headers.remove('Authorization');
      return;
    } else {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
