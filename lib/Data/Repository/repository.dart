import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Data/network/network_api_services.dart';
import 'package:woye_user/Presentation/Common/Otp/model/register_model.dart';

class Repository{
  final _apiService = NetworkApiServices();

  Future<dynamic> registerApi(data, token) async{
dynamic response = await _apiService.postApi(data, AppUrls.register, token);
return RegisterModel.fromJson(response);
  }
}