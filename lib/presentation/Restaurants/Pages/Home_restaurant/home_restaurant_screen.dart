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
    print("size of home widget ================> $height");
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
            height: 500,
            // height: Get.height - height,
            child: ListView(
              children: [
//                SliverStickyHeader(
//   header: Container(
//     height: 60.0,
//     color: Colors.lightBlue,
//     padding: EdgeInsets.symmetric(horizontal: 16.0),
//     alignment: Alignment.centerLeft,
//     child: Text(
//       'Header #0',
//       style: const TextStyle(color: Colors.white),
//     ),
//   ),
//   sliver: SliverList(
//     delegate: SliverChildBuilderDelegate(
//       (context, i) => ListTile(
//             leading: CircleAvatar(
//               child: Text('0'),
//             ),
//             title: Text('List tile #$i'),
//           ),
//       childCount: 4,
//     ),
//   ),
// ),
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
