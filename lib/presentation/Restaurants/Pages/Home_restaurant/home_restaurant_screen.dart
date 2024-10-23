import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';

class HomeRestaurantScreen extends StatefulWidget {
  const HomeRestaurantScreen({super.key});

  @override
  State<HomeRestaurantScreen> createState() => _HomeRestaurantScreenState();
}

class _HomeRestaurantScreenState extends State<HomeRestaurantScreen> {
  GlobalKey homeWidgetKey = GlobalKey();
  double? height;

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
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: REdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: false,
                    snap: true,
                    floating: true,
                    expandedHeight: 100.h,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      title: SizedBox(
                        height: 50.h,
                        child: (SearchBarWithFilter(
                          onFilterTap: () {},
                        )),
                      ),
                      centerTitle: true,
                    ),
                  ),
                ),
                SliverPadding(
                    padding: REdgeInsets.symmetric(horizontal: 0),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(
                        title: Text('Item #$index'),
                      ),
                      // childCount: 50, // Number of items
                    )))
                // SliverPadding(
                //   padding: REdgeInsets.symmetric(horizontal: 24),
                //   sliver: ListView(
                //     children: const [
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //       Text("data"),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
