import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';

class HomeRestaurantScreen extends StatefulWidget {
  const HomeRestaurantScreen({super.key});

  @override
  State<HomeRestaurantScreen> createState() => _HomeRestaurantScreenState();
}

class _HomeRestaurantScreenState extends State<HomeRestaurantScreen> {
  GlobalKey homeWidgetKey = GlobalKey();
  double height = 520;

  _getHeight(_) {
    final keyContext = homeWidgetKey.currentContext;
    if (keyContext != null) height = keyContext.size!.height;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_getHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeScreen(
            key: homeWidgetKey,
          ),
          SizedBox(
            height: Get.height - height,
            child: ListView(
              children: [
                StickyHeader(
                  header: Container(
                    height: 50.0,
                    color: Colors.blueGrey[700],
                    padding: EdgeInsets.symmetric(horizontal: 16.0.h),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Header #',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  content: SizedBox(
                    height: 40,
                    child: Image.asset(
                      ImageConstants.restaurantDisable,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200.0,
                    ),
                  ),
                ),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
                const Text("data"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
