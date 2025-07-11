
abstract class BaseApiServices {

  Future<dynamic> getApi(String url,String token) ;

  Future<dynamic> postApi(dynamic data, String url, String token) ;

  Future<dynamic> getApiWithoutToken(String url) ;

  Future<dynamic> getWithParams(String baseUrl, String token, {Map<String, dynamic>? params});

  Future<dynamic> postApi2(var data, String url, String token);


}