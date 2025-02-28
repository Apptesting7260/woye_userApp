import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

import '../../../../../Core/Utils/app_export.dart';

class PrescriptionController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  var profileImageGetUrl = "".obs;

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      File originalImage = File(pickedImage.path);
      int originalSize = await originalImage.length();
      print('Original image size: $originalSize bytes');

      image.value = originalImage;

      print("Path ---> ${image.value?.path}");

      File? croppedImage = await _cropImage(image.value!.path);

      if (croppedImage != null) {
        int croppedSize = await croppedImage.length();
        print('Cropped image size: $croppedSize bytes');
        image.value = croppedImage;
        profileImageGetUrl.value = croppedImage.path;
        print("Cropped image path ---> ${profileImageGetUrl.value}");
        // imageUploadApi();
      } else {
        print("Image cropping was canceled or failed.");
      }
    }
  }

  Future<File?> _cropImage(String filePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1.5, ratioY: 1.0),
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
        ),
      ],
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }
}
