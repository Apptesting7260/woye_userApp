import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Data/network/network_api_services.dart';
import 'package:woye_user/Presentation/Common/Otp/model/register_model.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Model/home_model.dart';
import 'package:woye_user/presentation/common/Otp/model/login_model.dart';
import 'package:woye_user/presentation/common/Sign_up_form/Model/getprofile_model.dart';
import 'package:woye_user/presentation/common/Sign_up_form/Model/updateprofile_model.dart';
import 'package:woye_user/presentation/common/Social_login/social_model.dart';

class Repository{
  final _apiService = NetworkApiServices();

  Future<dynamic> registerApi(data, token) async{
    dynamic response = await _apiService.postApi(data, AppUrls.register, token);
    return RegisterModel.fromJson(response);
  }

  Future<dynamic> loginApi(data, token) async{
    dynamic response = await _apiService.postApi(data, AppUrls.login, token);
    return LoginModel.fromJson(response);
  }

  Future<dynamic> getprofileApi(token) async{
    dynamic response = await _apiService.getApi(AppUrls.getProfile, token);
    return ProfileModel.fromJson(response);
  }

  Future<dynamic> updateprofileApi(data, token) async{
    dynamic response = await _apiService.postApi(data, AppUrls.updateProfile, token);
    return UpdateprofileModel.fromJson(response);
  }

  Future<dynamic> guestUserApi(data, token) async{
    dynamic response = await _apiService.postApi(data, AppUrls.guestUser, token);
    return RegisterModel.fromJson(response);
  }

  Future<dynamic> homeApi(token) async{
    dynamic response = await _apiService.getApi(AppUrls.homeApi, token);
    return HomeModel.fromJson(response);
  }

  Future<dynamic> SocialLoginApi(data, token) async{
    dynamic response = await _apiService.postApi(data, AppUrls.socialLogin, token);
    return SocialModel.fromJson(response);
  }

}