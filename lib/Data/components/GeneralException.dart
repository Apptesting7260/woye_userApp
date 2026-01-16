import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woye_user/Shared/theme/font_family.dart';

class GeneralExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;

  const GeneralExceptionWidget({Key? key, required this.onPress}) : super(key: key);

  @override
  _GeneralExceptionWidgetState createState() => _GeneralExceptionWidgetState();
}

class _GeneralExceptionWidgetState extends State<GeneralExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: height * .15,
          ),
          Icon(
            Icons.error,
            color: Colors.red, // Red to indicate an error
            size: Get.height * 0.18,
          ),
           Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                "Oops!\nSomething went wrong. Please try again.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFontFamily.onestMedium,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * .06,
          ),
          InkWell(
            onTap: widget.onPress, // Retry logic passed from the parent widget
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.red, // Retry button color (red for general error)
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "Retry",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFontFamily.onestMedium,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
