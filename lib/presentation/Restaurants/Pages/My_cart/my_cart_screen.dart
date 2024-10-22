import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/shared/widgets/custom_header_notification.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [

            hBox(20),

            CustomHeaderWithNotification(title: 'My Cart',),

            hBox(20),

          ],
        ),
      ),
    );
  }
}