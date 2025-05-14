import 'dart:developer';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../Core/Utils/app_export.dart';

class PrescriptionController extends GetxController {
  // Rx<File?> image = Rx<File?>(null);
  RxList<Rx<File?>> imageList = RxList<Rx<File?>>([Rx<File?>(null)]);
    List<String> base64ImageList = <String>[].obs;

  // @override
  // void onInit() {
  //   imageList.clear();
  //   profileImageGetUrl.value = "";s
  //   // TODO: implement onInit
  //   super.onInit();
  // }

  // var profileImageGetUrl = "".obs;
  RxString imageBase64 = "".obs;
  // Future<void> pickImage(ImageSource source, int index) async {
  //   final pickedImage = await ImagePicker().pickImage(source: source);
  //
  //   if (pickedImage != null) {
  //     File originalImage = File(pickedImage.path);
  //     int originalSize = await originalImage.length();
  //     print('Original image size: $originalSize bytes');
  //
  //     // imageList[index].value = originalImage;
  //
  //     // print("Path ---> ${imageList[index].value?.path}");
  //
  //     File? croppedImage = await _cropImage(originalImage.path);
  //
  //     if (croppedImage != null) {
  //       int croppedSize = await croppedImage.length();
  //       print('Cropped image size: $croppedSize bytes');
  //       print("List base 64 $base64ImageList");
  //
  //       imageList[index].value = croppedImage;
  //       final base64 = await convertImageToBase64(croppedImage);
  //       base64ImageList.add(base64);
  //       print("List base 64 $base64ImageList");
  //       // profileImageGetUrl.value = croppedImage.path;
  //       // print("Cropped image path ---> ${profileImageGetUrl.value}");
  //       // imageUploadApi();
  //     } else {
  //       print("Image cropping was canceled or failed.");
  //     }
  //   }
  // }
  Future<void> pickImage(ImageSource source, int index) async {
    bool hasPermission = await _handlePermissions(source);
    if (!hasPermission) return;

    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        File originalImage = File(pickedImage.path);
        int originalSize = await originalImage.length();
        debugPrint('Original image size: $originalSize bytes');
        File? croppedImage = await _cropImage(originalImage.path);
        if (croppedImage != null) {
          int croppedSize = await croppedImage.length();
          debugPrint('Cropped image size: $croppedSize bytes');
          imageList[index].value = croppedImage;
          final base64 = await convertImageToBase64(croppedImage);
          if (index < base64ImageList.length) {
            base64ImageList[index] = base64;
          } else {
            base64ImageList.add(base64);
          }
          debugPrint("List base 64 $base64ImageList");
        } else {
          debugPrint("Image cropping was canceled or failed.");
        }
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }


  Future<bool> _handlePermissions(ImageSource source) async {
    if (source == ImageSource.camera) {
      var status = await Permission.camera.status;
      if (!status.isGranted) {
        status = await Permission.camera.request();
        if (status.isPermanentlyDenied || !status.isGranted) {
          showPermissionDialog(Get.context!, "Camera");
          return false;
        }
      }
      return true;
    } else {
      var status =  await Permission.photos.status;

      if (!status.isGranted) {
        status = await Permission.photos.request();
        if (status.isPermanentlyDenied || !status.isGranted) {
          showPermissionDialog(Get.context!, "Gallery");
          return false;
        }
      }
      return true;
    }
  }

  void showPermissionDialog(BuildContext context, String permissionType) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Center(child: Text("Permission Required")),
        content: Text(
          "$permissionType permission is denied. Please enable it in settings.",
          textAlign: TextAlign.start,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Get.back();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  Future<String> convertImageToBase64(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      imageBase64.value = base64Encode(bytes);
      log(imageBase64.value, name: "Base64IMAGE");
      return imageBase64.value;
    } catch (e) {
      debugPrint("Error converting image to Base64: $e");
      return '';
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
