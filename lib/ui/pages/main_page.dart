import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_shopping/providers/car_provider.dart';
import 'package:car_shopping/services/colors.dart';
import 'package:car_shopping/ui/pages/Favourite_page.dart';
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
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      label: 'cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite_outline,
      ),
      label: 'favourite',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.search,
      ),
      label: 'Search',
    ),
  ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return DefaultTabController(
        length: 4,
        child: Consumer<CarProvider>(builder: (context, provider, x) {
          return Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Palette.primary,
            // ),
            // bottomNavigationBar: BottomAppBar(
            //   shape: CircularNotchedRectangle(), //shape of notch
            //   notchMargin: 10,
            //   clipBehavior: Clip.antiAlias,
            //   //notche margin between floating button and bottom appbar
            //   child: BottomNavigationBar(
            //     unselectedItemColor: Color(0xFF6f52ed).withOpacity(0.6),
            //     fixedColor: Color(0xFF6f52ed),
            //     onTap: (tapedIndex) {
            //       this.index = tapedIndex;
            //       tabController.animateTo(tapedIndex);
            //       setState(() {});
            //     },
            //     currentIndex: index,
            //     items: items,
            //   ),
            // ),
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
                      // color: color,
                      child: ListTile(
                        title: Text('Item 1'),
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('');
                          setState(() {
                            // color = Palette.secondary;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Item 2'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),

            // body: TabBarView(
            //   controller: tabController,
            //   physics: NeverScrollableScrollPhysics(),
            //   children: [
            //     HomePage(),
            //     CartPage(),
            //     FavouritePage(),
            //     SearchPage(),
            //   ],
            // ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                            color: Palette.primary,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                  MediaQuery.of(context).size.width, 120),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Center(
                            child: SizedBox(
                              height: 200,
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
                                        width: width * 0.8,
                                        height: height * 0.2,
                                        // color: Palette.primary,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CarouselSlider(
                                              items: provider.allCars
                                                  .map(
                                                    (e) => CachedNetworkImage(
                                                        imageUrl:
                                                            'https://stat.overdrive.in/wp-content/odgallery/2020/06/57263_2020_Mercedes_Benz_GLS.jpg'),
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
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
