import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';

class PharmacyNavbar extends StatelessWidget {
  const PharmacyNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeScreen(),
        ],
      ),
    );
  }
}
