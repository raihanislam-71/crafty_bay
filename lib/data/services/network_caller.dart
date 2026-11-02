import 'dart:convert';

import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkCaller {
  final Logger logger;
  final AuthController authController;

  NetworkCaller({required this.logger, required this.authController});

  Future<NetworkResponse> getRequest({
    required String url,
    String? token,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLog(url, {}, {}, '');
      final http.Response response = await http.get(
        uri,
        headers: {'token': '${token ?? AuthController.accessToken}'},
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
        if (response.statusCode == 401) {
          _moveToLogin();
        }
        dynamic decodedBody;
        try {
          decodedBody = jsonDecode(response.body);
        } catch (_) {}
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedBody,
          errorMassage: decodedBody is Map<String, dynamic>
              ? decodedBody['msg']?.toString()
              : null,
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
    String? token,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLog(url, {}, body ?? {}, '');
      final http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'token': '${token ?? AuthController.accessToken}',
          'Content-Type': 'application/json',
        },
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
        if (response.statusCode == 401) {
          _moveToLogin();
        }
        dynamic decodedBody;
        try {
          decodedBody = jsonDecode(response.body);
        } catch (_) {}
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedBody,
          errorMassage: decodedBody is Map<String, dynamic>
              ? decodedBody['msg']?.toString()
              : null,
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

  Future<NetworkResponse> deleteRequest({
    required String url,
    String? token,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      _requestLog(url, {}, {}, '');
      final http.Response response = await http.delete(
        uri,
        headers: {'token': '${token ?? AuthController.accessToken}'},
      );

      if (response.statusCode == 200) {
        _responseLog(
          url,
          response.statusCode,
          response.body,
          response.headers,
          true,
        );
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      }

      _responseLog(
        url,
        response.statusCode,
        response.body,
        response.headers,
        false,
      );
      if (response.statusCode == 401) {
        _moveToLogin();
      }
      dynamic decodedBody;
      try {
        decodedBody = jsonDecode(response.body);
      } catch (_) {}
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: decodedBody,
        errorMassage: decodedBody is Map<String, dynamic>
            ? decodedBody['msg']?.toString()
            : null,
      );
    } catch (e) {
      _responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }

  Future<void> _moveToLogin() async {
    await authController.clearUserData();
    Get.to(() => const EmailVerificationScreen());
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
