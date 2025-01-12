import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
import '../exceptions/error_handler.dart';
import '../exceptions/failure.dart';

class ApiInterceptor {

  final String baseUrl;
  final String? accessToken;

  ApiInterceptor({required this.baseUrl, this.accessToken});


   Future<http.Response> delete({required String endPoint}) async{
    final Uri url = Uri.parse(endPoint);
    final headers = _buildHeaders();

    try{
      log('Delete Request: $url', name: 'ApiInterceptor');
     final http.Response response = await http.delete(url, headers: headers);
      _logResponse(response);
      _handleResponseErrors(response);
      return response;
    }catch(error,stackTrace){
      _handleError(error,stackTrace);
      rethrow;
    }
}

  Future<http.Response> get({required String endPoint}) async{
    final Uri url = Uri.parse(endPoint);
    final headers = _buildHeaders();

    try{
      log('Get Request: $url', name: 'ApiInterceptor');
      final http.Response response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));
      _logResponse(response);
      _handleResponseErrors(response);
      return response;
    }catch(error,stackTrace){
      _handleError(error,stackTrace);
      rethrow;
    }
  }

  Future<http.Response> post({
    required String endPoint,
    required Map<String, dynamic> requestBody,
  }) async{
    final Uri url = Uri.parse(endPoint);
    final headers = _buildHeaders();

    try {
      log('POST Request: $url', name: 'ApiInterceptor');
      log('Body: ${jsonEncode(requestBody)}', name: 'ApiInterceptor');
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );
      _logResponse(response);
      _handleResponseErrors(response);
      return response;
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
      rethrow;
    }
  }


  Future<http.Response> put({
    required String endPoint,
    required Map<String, dynamic> requestBody,
  }) async{
    final Uri url = Uri.parse(endPoint);
    final headers = _buildHeaders();

    try {
      log('PUT Request: $url', name: 'ApiInterceptor');
      log('Body: ${jsonEncode(requestBody)}', name: 'ApiInterceptor');
      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );
      _logResponse(response);
      _handleResponseErrors(response);
      return response;
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
      rethrow;
    }
  }

  Future<http.Response> postMultipart(String endpoint,
      {required Map<String, String> fields,
        required List<http.MultipartFile> files}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = _buildHeaders();

    try {
      log('Multipart POST Request: $uri', name: 'ApiInterceptor');

      final request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers)
        ..fields.addAll(fields);

      for (var file in files) {
        request.files.add(file);
      }

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      _logResponse(responseBody);
      _handleResponseErrors(responseBody);
      return responseBody;

    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
      rethrow;
    }
  }


  Map<String, String> _buildHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  void _logResponse(http.Response response) {
    log('Response: ${response.statusCode}', name: 'ApiInterceptor');
    log('Body: ${response.body}', name: 'ApiInterceptor');
  }

  void _handleResponseErrors(http.Response response) {
    if (response.statusCode >= 400) {
      final failure = _mapResponseToFailure(response);
      ErrorHandler.logError(failure);
      throw failure;
    }
  }

  Failure _mapResponseToFailure(http.Response response) {
    switch (response.statusCode) {
      case 400:
        return ValidationFailure(message: 'Bad Request: ${response.body}');
      case 401:
        return AuthenticationFailure(message: 'Unauthorized access.');
      case 403:
        return AuthenticationFailure(message: 'Forbidden access.');
      case 404:
        return ValidationFailure(message: 'Resource not found.');
      case 500:
      case 503:
        return ServerFailure(message: 'Server error occurred.');
      default:
        return UnknownFailure(message: 'Unexpected error: ${response.body}');
    }
  }

  void _handleError(dynamic error, StackTrace? stackTrace) {
    final failure = FailureMapper.map(error);
    ErrorHandler.logError(failure, stackTrace);
    if (error is http.ClientException) {
      throw NetworkError(message: 'Network error occurred.');
    }
    if (error is TimeoutException) {
      throw TimeoutError(message: 'The request timed out.');
    }
    throw UnknownFailure(message: 'An unexpected error occurred: $error');
  }

}