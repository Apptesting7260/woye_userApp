import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../components/InternetException.dart';
import '../app_exceptions.dart';
import '../components/RequestTimeOut.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  Future<dynamic> getApiWithoutToken(String url) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url),
          headers: {"Authorization": ""}).timeout(const Duration(seconds: 50));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptionWidget(
        onPress: () {},
      );
    } on RequestTimeOut {
      throw RequestTimeOut(
        onPress: () {},
      );
    }
    print(responseJson);
    return responseJson;
  }

  @override
  Future<dynamic> getApi(String url, String token) async {
    print("tocken@calling : ${token.toString()}");
    print("Get url@calling : ${url.toString()}");
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer $token"
      }).timeout(const Duration(seconds: 50));

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptionWidget(
        onPress: () {},
      );
    } on RequestTimeOut {
      throw RequestTimeOut(
        onPress: () {},
      );
    }
    print(responseJson);
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url, String token) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      print("tocken@calling : ${token.toString()}");
      print("post url@calling : ${url.toString()}");
      final response = await http
          .post(Uri.parse(url),
              headers: {"Authorization": "Bearer $token",}, body: data)
          .timeout(const Duration(seconds: 50));
      responseJson = returnResponse(response);
      print("data: $response");
    } on SocketException {
      throw InternetExceptionWidget(
        onPress: () {},
      );
    } on RequestTimeOut {
      throw RequestTimeOut(
        onPress: () {},
      );
    }
    if (kDebugMode) {
      print("$responseJson");
    }
    return responseJson;
  }

  Future<dynamic> postApi2(var data, String url, String token) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {
      print("tocken@calling : ${token.toString()}");
      print("post url@calling : ${url.toString()}");
      final response = await http
          .post(Uri.parse(url),
          headers: {"Authorization": "Bearer $token",'Content-Type': 'application/json',}, body: data)
          .timeout(const Duration(seconds: 50));
      responseJson = returnResponse(response);
      print("data: $response");
    } on SocketException {
      throw InternetExceptionWidget(
        onPress: () {},
      );
    } on RequestTimeOut {
      throw RequestTimeOut(
        onPress: () {},
      );
    }
    if (kDebugMode) {
      print("$responseJson");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    print("response.statusCode ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 503:
        throw UnauthenticatedException();
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 405:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 501:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      default:
        throw FetchDataException(
            'Error accoured while communicating with server ${response.statusCode}');
      // default:
      //   dynamic responseJson = jsonDecode(response.body);
      //   return responseJson;
    }
  }
}
