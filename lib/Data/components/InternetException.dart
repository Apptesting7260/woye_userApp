import 'package:woye_user/Shared/theme/font_family.dart';

import '../../Core/Utils/app_export.dart';

class InternetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  final bool? isAppbar;

  const InternetExceptionWidget({Key? key, required this.onPress,this.isAppbar})
      : super(key: key);

  @override
  State<InternetExceptionWidget> createState() =>
      _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: widget.isAppbar == false ? height * .25 : height * .14,
          ),
          Icon(
            Icons.wifi_off_rounded,
            color: AppColors.primary,
            size: Get.height * 0.18,
          ),
           Padding(
            padding: REdgeInsets.only(top: 5),
            child:  Center(
                child: Column(
                  children: [
                    Text(
                      "Oops!",
                      // "Oh no!\nYour internet took a coffee break!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFontFamily.onestMedium,
                      ),
                    ),
                    hBox(20.h),
                    Text(
                      "No Internet connection found \n Check your connection.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFontFamily.onestMedium,
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: height * .06,
          ),
          InkWell(
            onTap: widget.onPress,
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50.r)),
              child: Center(
                  child: Text(
                    "Retry",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFontFamily.onestMedium,
                        color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
