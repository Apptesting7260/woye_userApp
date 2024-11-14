import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:woye_user/core/utils/app_export.dart';

class PharmacyVendorReviewScreen extends StatefulWidget {
  const PharmacyVendorReviewScreen({super.key});

  @override
  State<PharmacyVendorReviewScreen> createState() =>
      _PharmacyVendorReviewScreenState();
}

class _PharmacyVendorReviewScreenState extends State<PharmacyVendorReviewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationController.animateTo(0.5);
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Reviews",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hBox(20),
            ratings(),
            hBox(50),
            LinearProgressIndicator(
              backgroundColor: AppColors.greyBackground,
              value: _animationController.value,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }

  Widget ratings() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Text(
                "4.5",
                style:
                    AppFontStyle.text_36_600(AppColors.darkText, height: 1.0),
              ),
              Text(
                "Rating",
                style: AppFontStyle.text_14_400(AppColors.darkText),
              ),
            ],
          ),
        ),
        Expanded(
            flex: 7,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  RatingBar(
                      itemSize: 16.h,
                      initialRating: 4,
                      allowHalfRating: false,
                      ratingWidget: RatingWidget(
                          full: SvgPicture.asset("assets/svg/star-yellow.svg"),
                          half: SvgPicture.asset("assets/svg/star-white.svg"),
                          empty: SvgPicture.asset("assets/svg/star-white.svg")),
                      onRatingUpdate: (v) {}),
                  SizedBox(
                    width: 100,
                    child: LinearProgressIndicator(
                      backgroundColor: AppColors.greyBackground,
                      value: 50,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                    ),
                  )
                ],
              )
            ])),
      ],
    );
  }

  List<SalesData> getChartData() {
    return [
      SalesData('2015', 30, 70),
      SalesData('2016', 40, 60),
      SalesData('2017', 50, 50),
      SalesData('2018', 60, 40),
    ];
  }
}

class SalesData {
  SalesData(this.year, this.sales1, this.sales2);
  final String year;
  final double sales1;
  final double sales2;
}
