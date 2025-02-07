import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:intl/intl.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Reviews/modal/see_all_review_modal.dart';

class SeeAllProductReviewController extends GetxController {
  final api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final seeAllReview = ReviewResponse().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void seeAllReviewSet(ReviewResponse value) => seeAllReview.value = value;

  void setError(String value) => error.value = value;

  seeAllProductReviewApi({
    required String productId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "restaurant_id": productId,
    };
    api.seeAllReviewApi(data).then((value) {
      seeAllReviewSet(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  String formatDate(String? dateString) {
    if (dateString == null) {
      return "";
    }
    try {
      DateTime date = DateTime.parse(dateString);
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);
      print("Formatted Date: $formattedDate");
      return formattedDate;
    } catch (e) {
      print("Error formatting date: $e");
      return "";
    }
  }
}
