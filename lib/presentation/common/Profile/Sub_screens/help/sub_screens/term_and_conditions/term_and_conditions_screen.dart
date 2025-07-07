import 'package:webview_flutter/webview_flutter.dart';
import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';

class TermAndConditionsScreen extends StatefulWidget {
  const TermAndConditionsScreen({super.key});

  @override
  State<TermAndConditionsScreen> createState() => _TermAndConditionsScreenState();
}

class _TermAndConditionsScreenState extends State<TermAndConditionsScreen> {
  WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(AppUrls.termsConditions));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isLeading: true,
      ),
      body: WebViewWidget(controller: controller),
      // body: SingleChildScrollView(
      //   padding: REdgeInsets.symmetric(horizontal: 24),
      //   child: Column(
      //    
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         "Term and Conditions",
      //         style: AppFontStyle.text_24_600(AppColors.darkText),
      //       ),
      //       hBox(20),
      //       Text(
      //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      //         overflow: TextOverflow.visible,
      //         style: AppFontStyle.text_14_400(AppColors.lightText),
      //       ),
      //       hBox(15),
      //       Text(
      //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      //         overflow: TextOverflow.visible,
      //         style: AppFontStyle.text_14_400(AppColors.lightText),
      //       ),
      //       hBox(15),
      //       Text(
      //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      //         overflow: TextOverflow.visible,
      //         style: AppFontStyle.text_14_400(AppColors.lightText),
      //       ),
      //       hBox(15),
      //       Text(
      //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      //         overflow: TextOverflow.visible,
      //         style: AppFontStyle.text_14_400(AppColors.lightText),
      //       ),
      //       hBox(15),
      //       Text(
      //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      //         overflow: TextOverflow.visible,
      //         style: AppFontStyle.text_14_400(AppColors.lightText),
      //       ),
      //       hBox(15),
      //       Text(
      //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      //         overflow: TextOverflow.visible,
      //         style: AppFontStyle.text_14_400(AppColors.lightText),
      //       ),
      //       hBox(15),
      //       Text(
      //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      //         overflow: TextOverflow.visible,
      //         style: AppFontStyle.text_14_400(AppColors.lightText),
      //       ),
      //       hBox(15),
      //       Text(
      //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      //         overflow: TextOverflow.visible,
      //         style: AppFontStyle.text_14_400(AppColors.lightText),
      //       ),
      //       hBox(50)
      //     ],
      //   ),
      // ),
    );
  }
}
