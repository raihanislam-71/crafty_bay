import 'dart:convert';

import 'package:crafty_bay/data/models/network_response.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkCaller {
  final Logger logger;

  NetworkCaller({required this.logger});

  Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLog(url, {}, {}, '');
      final http.Response response = await http.get(
        uri,
        headers: {'token': ''},
      );
      if (response.statusCode == 200) {
        _responseLog(
          url,
          response.statusCode,
          response.body,
          response.headers,
          true,
        );

        final decodedBody = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedBody,
        );
      } else {
        _responseLog(
          url,
          response.statusCode,
          response.body,
          response.headers,
          false,
        );

        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _responseLog(url, -1, null, {}, false, e);

      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLog(url, {}, body ?? {}, '');
      final http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'token': '', 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _responseLog(
          url,
          response.statusCode,
          response.body,
          response.headers,
          true,
        );

        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else {
        _responseLog(
          url,
          response.statusCode,
          response.body,
          response.headers,
          false,
        );
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  void _requestLog(
    String url,
    Map<String, dynamic> params,
    Map<String, dynamic> body,
    String token,
  ) {
    logger.i('''
      Url : $url
      Params : $params
      Body : $body
      Token : $token
      ''');
  }

  void _responseLog(
    String url,
    int statusCode,
    dynamic responseBody,
    Map<String, dynamic> headers,
    bool isSuccess, [
    dynamic error,
  ]) {
    String message =
        '''
    Url : $url
    StatusCode : $statusCode
    ResponseBody : $responseBody
    HeaderS : $headers
    Error : $error
    ''';

    if (isSuccess) {
      logger.i(message);
    } else {
      logger.e(message);
    }
  }
}
