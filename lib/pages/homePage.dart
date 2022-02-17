import 'package:crypto_tracker/models/crypto_model.dart';
import 'package:crypto_tracker/pages/detail_page.dart';
import 'package:crypto_tracker/pages/favorites.dart';
import 'package:crypto_tracker/pages/markets.dart';
import 'package:crypto_tracker/provider/market_provider.dart';
import 'package:crypto_tracker/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController viewController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back !',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Crypto Today',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    padding: const EdgeInsets.all(0),
                    icon: (themeProvider.themeMode == ThemeMode.light)
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TabBar(
                controller: viewController,
                indicator: CircleTabIndicator(
                    color: Color.fromARGB(255, 40, 217, 230), radius: 4),
                // labelColor: Colors.black,
                // unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    child: Text('Markets',
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  Tab(
                    child: Text('Favorites',
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    controller: viewController,
                    children: const [
                      Markets(),
                      Favorites(),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// TAB BAR INDICATOR DESIGN
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;

  _CirclePainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration config) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(config.size!.width / 2, config.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
