// ignore: unused_import
import 'package:get/get.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/Routes/app_routes.dart';

import '../Core/Utils/snackbar.dart';


class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, 'No internet');
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, 'Request Time out');
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, 'Internal server error');
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message]) : super(message, 'Invalid Url');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, '');
}

UserPreference userPreference = UserPreference();

class UnauthenticatedException extends AppExceptions {
  UnauthenticatedException([String? message])
      : super(message, "Authenticated Expired") {
    userPreference.removeUser().then((value) {
      Get.offAllNamed(AppRoutes.login);
      SnackBarUtils.showToastCenter("Your Session is Expired Please Re-login");
    });
  }
}
