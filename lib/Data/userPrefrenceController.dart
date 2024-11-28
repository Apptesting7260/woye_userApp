
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woye_user/Data/Model/usermodel.dart';

class UserPreference {
  Future<bool> saveUser(UserModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', responseModel.token.toString());
    sp.setBool('isLogin', responseModel.isLogin!);
    sp.setInt('Step', responseModel.step!);
    sp.setString('loginType', responseModel.loginType!);
    print('token ===>>> ${sp.getString('token')}');

    return true;
  }

  Future<void> saveStep(int step) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('Step', step);
  }

  Future<UserModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    bool? isLogin = sp.getBool('isLogin');
    int? Step = sp.getInt('Step');
    String? loginType = sp.getString('loginType');

    return UserModel(token: token, isLogin: isLogin, step: Step, loginType: loginType);
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}
