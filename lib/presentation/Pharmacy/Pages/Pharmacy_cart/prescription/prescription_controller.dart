import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

import '../../../../../Core/Utils/app_export.dart';

class PrescriptionController extends GetxController {
  // Rx<File?> image = Rx<File?>(null);
  RxList<Rx<File?>> imageList = RxList<Rx<File?>>([Rx<File?>(null)]);

  // @override
  // void onInit() {
  //   imageList.clear();
  //   profileImageGetUrl.value = "";
  //   // TODO: implement onInit
  //   super.onInit();
  // }

  // var profileImageGetUrl = "".obs;

  Future<void> pickImage(ImageSource source, int index) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      File originalImage = File(pickedImage.path);
      int originalSize = await originalImage.length();
      print('Original image size: $originalSize bytes');

      // imageList[index].value = originalImage;

      // print("Path ---> ${imageList[index].value?.path}");

      File? croppedImage = await _cropImage(originalImage.path);

      if (croppedImage != null) {
        int croppedSize = await croppedImage.length();
        print('Cropped image size: $croppedSize bytes');
        imageList[index].value = croppedImage;
        // profileImageGetUrl.value = croppedImage.path;
        // print("Cropped image path ---> ${profileImageGetUrl.value}");
        // imageUploadApi();
      } else {
        print("Image cropping was canceled or failed.");
      }
    }
  }

  Future<File?> _cropImage(String filePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.5),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: Colors.black,
          activeControlsWidgetColor: AppColors.primary,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true ,
        ),
      ],
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }
}
