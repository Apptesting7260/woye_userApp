// // ignore_for_file: avoid_print


// import 'package:get/get_connect/connect.dart';
// import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

// class ApiClient extends GetConnect {
//   @override
//   void onInit() {
//     httpClient.baseUrl = ApiConstants.baseUrl; // Replace with your base URL
//     super.onInit();
//   }

//   // Method to get common headers
//   Map<String, String> _getCommonHeaders() {
//     return {
//       // Add other common headers here
//     };
//   }

//   Future<Response> getData(String url,
//       {Map<String, dynamic>? queryParams, Map<String, String>? headers}) async {
//     try {
//       final response = await get(url,
//           query: queryParams, headers: headers ?? _getCommonHeaders());
//       return _handleResponse(response);
//     } catch (e) {
//       return _handleError(e);
//     }
//   }

//   Future<Response> postData(String url, dynamic body,
//       {Map<String, String>? headers}) async {
//     try {
//       print('test pots');
//       final response =
//           await post(url, body, headers: headers ?? _getCommonHeaders());
//       print(url);
//       print("resoponse at api page========>${response.body}");

//       return _handleResponse(response);
//     } catch (e) {
//       print('error');
//       print(e.toString());
//       return _handleError(e);
//     }
//   }

//   Future<Response> multipartRequest(String url, FormData formData,
//       {Map<String, String>? headers}) async {
//     try {
//       final response =
//           await post(url, formData, headers: headers ?? _getCommonHeaders());
//       return _handleResponse(response);
//     } catch (e) {
//       return _handleError(e);
//     }
//   }

//   // Handle HTTP response
//   Response _handleResponse(Response response) {
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       // Request successful
//       return response;
//     } else {
//       return Response(
//         statusCode: response.statusCode,
//         statusText: 'Error: ${response.statusCode} ${response.statusText}',
//       );
//     }
//   }

//   // Handle exceptions
//   Response _handleError(dynamic error) {
//     String errorMessage = 'An unexpected error occurred';
//     if (error is GetHttpException) {
//       errorMessage = 'Network error: ${error.message}';
//     }

//     return Response(statusCode: 1, statusText: errorMessage);
//   }
// }
