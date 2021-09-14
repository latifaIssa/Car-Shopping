import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_shopping/providers/car_provider.dart';
import 'package:car_shopping/services/colors.dart';
import 'package:car_shopping/services/routes.dart';
import 'package:car_shopping/ui/pages/Favourite_page.dart';
import 'package:car_shopping/ui/pages/avaliable_cars.dart';
import 'package:car_shopping/ui/pages/cart_page.dart';
import 'package:car_shopping/ui/pages/home_page.dart';
import 'package:car_shopping/ui/pages/search_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int index = 0;
  TabController tabController;
  Color color;
  // final List<BottomNavigationBarItem> items = [
  //   BottomNavigationBarItem(
  //     icon: Icon(
  //       Icons.home,
  //     ),
  //     label: 'home',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.shopping_cart_outlined),
  //     label: 'cart',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(
  //       Icons.favorite_outline,
  //     ),
  //     label: 'favourite',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(
  //       Icons.search,
  //     ),
  //     label: 'Search',
  //   ),
  // ];
  final List<Tab> items = [
    Tab(
      icon: Icon(
        Icons.home,
      ),
      text: 'home',
    ),
    Tab(
      icon: Icon(Icons.shopping_cart_outlined),
      text: 'cart',
    ),
    Tab(
      icon: Icon(
        Icons.favorite_outline,
      ),
      text: 'favourite',
    ),
    Tab(
      icon: Icon(
        Icons.search,
      ),
      text: 'Search',
    ),
  ];
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
    color = Colors.transparent;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return DefaultTabController(
        length: 4,
        child: Consumer<CarProvider>(builder: (context, provider, x) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Palette.primary,
              elevation: 0,
              // bottom: TabBar(tabs: [

              // ],

              // ,),
            ),
            bottomNavigationBar: TabBar(
              tabs: items,
            ),
            endDrawer: ClipRRect(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.elliptical(150, 150)),
              child: Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      color: color,
                      child: ListTile(
                        title: Text('My Cart'),
                        onTap: () {
                          RouteHelper.routeHelper.goToPage(CartPage.routeName);
                          setState(() {
                            color = Palette.secondary;
                          });
                        },
                      ),
                    ),
                    Container(
                      color: color,
                      child: ListTile(
                        title: Text('Favourite'),
                        onTap: () {
                          RouteHelper.routeHelper
                              .goToPage(FavouritePage.routeName);
                          setState(() {
                            color = Palette.secondary;
                          });
                        },
                      ),
                    ),
                    Container(
                      color: color,
                      child: ListTile(
                        title: Text('Search'),
                        onTap: () {
                          RouteHelper.routeHelper
                              .goToPage(SearchPage.routeName);
                          setState(() {
                            color = Palette.secondary;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 0.3 * height,
                        // child: Text('Pick your favourite car'),
                        decoration: BoxDecoration(
                          color: Palette.primary,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                MediaQuery.of(context).size.width, 120),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: height * 0.08,
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Pick your favourite car',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: SizedBox(
                            height: height * 0.4,
                            child: provider.allCars == null
                                ? Container(
                                    color: Colors.white,
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // color: Palette.primary,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 20,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: CarouselSlider(
                                            items: provider.allCars
                                                .map(
                                                  (e) => Card(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10,
                                                    ),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    elevation: 4,
                                                    child: Column(
                                                      children: [
                                                        CachedNetworkImage(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          imageUrl:
                                                              'https://stat.overdrive.in/wp-content/odgallery/2020/06/57263_2020_Mercedes_Benz_GLS.jpg',
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Text(
                                                          e.car +
                                                              ' ' +
                                                              e.carModel,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Palette
                                                                .secondary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Text(
                                                          e.price + '\$',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Palette
                                                                .secondary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.03,
                                                        ),
                                                        RaisedButton(
                                                          color:
                                                              Palette.secondary,
                                                          onPressed: () {},
                                                          child: Container(
                                                            child: Text(
                                                              'Book Now',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            decoration: BoxDecoration(
                                                                color: Palette
                                                                    .secondary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            options: CarouselOptions(
                                              height: 400,
                                              aspectRatio: 16 / 9,
                                              viewportFraction: 0.8,
                                              initialPage: 0,
                                              enableInfiniteScroll: true,
                                              autoPlay: true,
                                            )),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 25,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          'Avaliable Cars',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          'Long term short term',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        trailing: Container(
                          // color: Colors.white,
                          child: IconButton(
                            color: Palette.secondary,
                            onPressed: () {
                              RouteHelper.routeHelper
                                  .goToPage(AvaliableCarsPage.routeName);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                  // Expanded(
                  //   flex: 2,
                  //   child: TabBarView(
                  //     controller: tabController,
                  //     children: [
                  //       HomePage(),
                  //       CartPage(),
                  //       FavouritePage(),
                  //       SearchPage(),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        }));
  }
}
