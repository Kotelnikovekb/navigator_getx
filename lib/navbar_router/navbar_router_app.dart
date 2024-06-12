import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:navbar_router/navbar_router.dart';

class NavbarRouterApp extends StatefulWidget {
  const NavbarRouterApp({super.key});

  @override
  State<NavbarRouterApp> createState() => _NavbarRouterAppState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class _NavbarRouterAppState extends State<NavbarRouterApp> {
  DateTime oldTime = DateTime.now();
  DateTime newTime = DateTime.now();


  final Map<int, Map<String, Widget>> _routes = const {
    0: {
      '/': FeedDetail(),
      FeedDetail.route: FeedDetail(),
    },
    1: {
      '/': ProductList(),
      ProductDetail.route: ProductDetail(),
      ProductComments.route: ProductComments(),
    },
    2: {
      '/': UserProfile(),
      ProfileEdit.route: ProfileEdit(),
    },

  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<NavbarItem> items = [
      NavbarItem(Icons.home_outlined, 'Home',
          backgroundColor: colors[0],
          selectedIcon: const Icon(
            Icons.home,
            size: 26,
          )),
      NavbarItem(Icons.shopping_bag_outlined, 'Products',
          backgroundColor: colors[1],
          selectedIcon: const Icon(
            Icons.shopping_bag,
            size: 26,
          )),
      NavbarItem(Icons.person_outline, 'Me',
          backgroundColor: colors[2],
          selectedIcon: const Icon(
            Icons.person,
            size: 26,
          )),

    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NavbarRouter(
        errorBuilder: (context) {
          return const Center(child: Text('Error 404'));
        },
        //isDesktop: size.width > 600 ? true : false,
        onBackButtonPressed: (isExitingApp) {
          if (isExitingApp) {
            newTime = DateTime.now();
            int difference = newTime.difference(oldTime).inMilliseconds;
            oldTime = newTime;
            if (difference < 1000) {
              NavbarNotifier.hideSnackBar(context);
              return isExitingApp;
            } else {
              final state = Scaffold.of(context);
              NavbarNotifier.showSnackBar(
                context,
                "Tap back button again to exit",
                bottom: state.hasFloatingActionButton ? 0 : kNavbarHeight,
              );
              return false;
            }
          } else {
            return isExitingApp;
          }
        },
        initialIndex: 0,
        type: NavbarType.material3,
        destinationAnimationCurve: Curves.fastOutSlowIn,
        destinationAnimationDuration: 200,
        decoration: FloatingNavbarDecoration(
          height: 80,
          // minExtendedWidth: 226,
          // minWidth: 92,
          borderRadius: BorderRadius.circular(20),
          isExtended: size.width > 800 ? true : false,
          // labelTextStyle: const TextStyle(
          //     color: Color.fromARGB(255, 176, 207, 233), fontSize: 14),
          // elevation: 3.0,
          // indicatorShape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(20)),
          // ),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          // indicatorColor: const Color.fromARGB(255, 176, 207, 233),
          // // iconTheme: const IconThemeData(color: Colors.indigo),
          // /// labelTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
          // labelBehavior: NavigationDestinationLabelBehavior.alwaysShow
        ),
        onChanged: (x) {
         // ref.read(appProvider.notifier).setIndex(x);
        },
        backButtonBehavior: BackButtonBehavior.rememberHistory,
        destinations: [
          for (int i = 0; i < items.length; i++)
            DestinationRouter(
              navbarItem: items[i],
              destinations: [
                for (int j = 0; j < _routes[i]!.keys.length; j++)
                  Destination(
                    route: _routes[i]!.keys.elementAt(j),
                    widget: _routes[i]!.values.elementAt(j),
                  ),
              ],
              initialRoute: _routes[i]!.keys.first,
            ),
        ],
        key: navigatorKey,
      ),
    );
  }
}
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
              onPressed: (){
                Get.toNamed('/product');
              },
              child: Text('Go to Product Page')
          )
        ],
      ),
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Product Page'),
        ),
      ),
    );
  }
}

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Shop Page'),
        ),
      ),
    );
  }
}
class FeedDetail extends StatelessWidget {
  final String feedId;
  const FeedDetail({Key? key, this.feedId = '1'}) : super(key: key);
  static const String route = '/feeds/detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed $feedId'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Placeholder(
                fallbackHeight: 200,
                fallbackWidth: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final String id;
  const ProductDetail({Key? key, this.id = '1'}) : super(key: key);
  static const String route = '/products/detail';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final argsId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Product $argsId'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('My AWESOME Product $argsId'),
          const Center(
            child: Placeholder(
              fallbackHeight: 200,
              fallbackWidth: 300,
            ),
          ),
          TextButton(
              onPressed: () {
                NavbarNotifier.hideBottomNavBar = false;
                Navigate.pushNamed(context, ProductComments.route,
                    arguments: {'id': argsId.toString()});
              },
              child: const Text('show comments'))
        ],
      ),
    );
  }
}

class ProductComments extends StatelessWidget {
  final String id;
  const ProductComments({Key? key, this.id = '1'}) : super(key: key);
  static const String route = '/products/detail/comments';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments on Product $id'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60,
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.secondaryContainer,
              title: Text('Comment $index'),
            ),
          ),
        );
      }),
    );
  }
}
class UserProfile extends StatefulWidget {
  static const String route = '/';

  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}
class _UserProfileState extends State<UserProfile> {
  final GlobalKey iconKey = GlobalKey();

  final Uri _url = Uri.parse('https://docs.maheshjamdade.com/navbar_router/');

  Future<void> _launchUrl() async {
    /*if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }*/
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
          centerTitle: false,
          actions: [
            IconButton(
              tooltip: 'show  Docs',
              icon: const Icon(Icons.edit_document),
              onPressed: _launchUrl,
            ),
            IconButton(
              key: iconKey,
              icon: const Icon(Icons.edit),
              onPressed: () {
                final RenderBox? renderBox =
                iconKey.currentContext!.findRenderObject() as RenderBox?;
                final offset = renderBox!.localToGlobal(Offset.zero);
                Navigate.push(context, const ProfileEdit(),
                    isRootNavigator: true,
                    offset: offset,
                    transitionType: TransitionType.reveal);
              },
            ),
          ],
          title: const Text('Hi User')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hi! This is your Profile Page'),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  NavbarNotifier.showSnackBar(
                    context,
                    "This is a Floating SnackBar",
                    actionLabel: "Tap to close",
                    onActionPressed: () {
                      NavbarNotifier.hideSnackBar(context);
                    },
                    bottom: NavbarNotifier.currentIndex > 1 ? kNavbarHeight : 0,
                  );
                },
                child: const Text('Show SnackBar')),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
                onPressed: () {
                  NavbarNotifier.popRoute(1);
                },
                child: const Text('Pop Product Route')),
          ],
        ),
      ),
    );
  }
}
class ProfileEdit extends StatelessWidget {
  static const String route = '/profile/edit';

  const ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Edit')),
      body: const Center(
        child: Text('Notice this page does not have bottom navigation bar'),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});
  static const String route = '/';

  @override
  State<StatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    if (size.width < 600) {
      _addScrollListener();
    }
  }

  void handleScroll() {
    if (size.width > 600) return;
    if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (NavbarNotifier.isNavbarHidden) {
        NavbarNotifier.hideBottomNavBar = false;
      }
    } else {
      if (!NavbarNotifier.isNavbarHidden) {
        NavbarNotifier.hideBottomNavBar = true;
      }
    }
  }

  void _addScrollListener() {
    _scrollController.addListener(handleScroll);
  }

  Size size = Size.zero;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    if (index == 0) {
                      NavbarNotifier.pushNamed(FeedDetail.route, 0);
                      NavbarNotifier.showSnackBar(context, 'switching to Home',
                          onClosed: () {
                            NavbarNotifier.index = 0;
                          });
                    } else {
                      NavbarNotifier.hideBottomNavBar = false;
                      Get.toNamed(ProductDetail.route,arguments: {'id': index.toString()},id: navigatorKey);
                      /*Navigate.pushNamed(context, ProductDetail.route,
                          transitionType: TransitionType.scale,
                          arguments: {'id': index.toString()});*/
                    }
                  },
                  child: ProductTile(index: index)),
            );
          }),
    );
  }
}
class ProductTile extends StatelessWidget {
  final int index;
  const ProductTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                height: 75,
                width: 75,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Flexible(
                child: Text(
                  index != 0
                      ? 'Product $index'
                      : 'Tap to push a route on HomePage Programmatically',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          )),
    );
  }
}
