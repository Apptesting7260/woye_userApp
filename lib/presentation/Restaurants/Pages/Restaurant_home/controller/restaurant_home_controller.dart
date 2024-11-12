import 'dart:developer';

import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Model/home_model.dart';

class RestaurantHomeController extends GetxController {
  List<Map<dynamic, dynamic>> restaurantList = [
    {
      "title": "The Pizza Hub And Restaurants",
      "type": "Pure veg",
      "image": "assets/images/restaurant-0.png",
      "isFavourite": false
    },
    {
      "title": "Casa Della Saucy",
      "type": "Veg and Non Veg",
      "image": "assets/images/restaurant-1.png",
      "isFavourite": false
    },
    {
      "title": "The Royal Restaurants",
      "type": "Pure veg",
      "image": "assets/images/restaurant-2.png",
      "isFavourite": false
    },
  ];

  void changeFavorite(index) {
    restaurantList[index]["isFavourite"] =
        !restaurantList[index]["isFavourite"];
    print("check==============>${restaurantList[index]["isFavourite"]}");
    update();
  }



  final api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final homeData = HomeModel().obs;
  RxString error = ''.obs;


  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void homeSet(HomeModel _value) => homeData.value = _value;
  void setError(String _value) => error.value = _value;

  @override
  void onInit() {
    homeApi();
    // TODO: implement onInit
    super.onInit();
  }


  homeApi() async {

    UserModel userModel = UserModel();
    var pref = UserPreference();
    userModel = await pref.getUser();

    setRxRequestStatus(Status.LOADING);

    api.homeApi(userModel.token.toString()).then((value) {

      setRxRequestStatus(Status.COMPLETED);
      homeSet(value);

      if (homeData.value.status == true) {
        log('home data ==>>${homeData.toString()}');
      }

    }).onError((error, stackError) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });

  }



}
