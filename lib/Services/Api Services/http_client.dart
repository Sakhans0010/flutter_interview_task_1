// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'app_exceptions.dart';

import 'package:http/http.dart' as http;

class HttpClient {
  static const int TIME_OUT_DURATION = 20;

  //GET
  Future<dynamic> get(
    String api, {
    Map<String, String>? headers,
  }) async {
    var uri = Uri.parse(api);
    try {
      var response = await http
          .get(
            uri,
            headers: headers,
          )
          .timeout(
            const Duration(
              seconds: TIME_OUT_DURATION,
            ),
          );
      return jsonDecode(response.body);
      // return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(
    String api,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    var uri = Uri.parse(api);

    var postBody = json.encode(body);

    try {
      var response = await http
          .post(
            uri,
            body: postBody,
            headers: headers,
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      print(response.body);

      return jsonDecode(response.body);
      // return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  dynamic _processResponse(response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 201:
        return response.body;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
        return response.body;
      case 403:
        return response.body;
      // throw UnAuthorizedException(
      //     utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
