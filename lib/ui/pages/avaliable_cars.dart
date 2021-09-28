import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_shopping/providers/car_provider.dart';
import 'package:car_shopping/services/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:provider/provider.dart';

class AvaliableCarsPage extends StatefulWidget {
  static final routeName = 'available';

  @override
  _AvaliableCarsPageState createState() => _AvaliableCarsPageState();
}

class _AvaliableCarsPageState extends State<AvaliableCarsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CarProvider>(context, listen: false).getAvailableCars();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Consumer<CarProvider>(builder: (context, provider, x) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: height * 0.1,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(
                horizontal: 5,
                // vertical: 5,
              ),
              width: 20,
              height: 7,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[200],
                ),
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: IconButton(
                alignment: Alignment.center,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  textDirection: TextDirection.ltr,
                  color: GlobalColors.primary,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                // padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(15),
                alignment: Alignment.topLeft,
                child: Text(
                  'Availabile Cars:',
                  style: TextStyle(
                    color: Color(0xFF141414),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // SizedBox(
              //   height: height * 0.1,
              // ),
              Expanded(
                child: CustomScrollView(
                  dragStartBehavior: DragStartBehavior.start,
                  slivers: [
                    SliverToBoxAdapter(
                      child: MasonryGrid(
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 10,
                        staggered: true,
                        column: 2,
                        children: List.generate(
                          provider.AvailableCars.length,
                          (i) => Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 4,
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  alignment: Alignment.topCenter,
                                  imageUrl:
                                      'https://stat.overdrive.in/wp-content/odgallery/2020/06/57263_2020_Mercedes_Benz_GLS.jpg',
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  provider.AvailableCars[i].car +
                                      ' ' +
                                      provider.AvailableCars[i].carModel,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: GlobalColors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  provider.AvailableCars[i].price + '\$',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: GlobalColors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                RaisedButton(
                                  color: GlobalColors.secondary,
                                  onPressed: () {},
                                  child: Container(
                                    child: Text(
                                      'Book Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: GlobalColors.secondary,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                ListTile(
                                  leading: IconButton(
                                    onPressed: () {
                                      provider.addToFavourite(
                                          provider.AvailableCars[i]);
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: provider.favouriteProducts?.any(
                                                  (element) =>
                                                      element.id ==
                                                      provider.AvailableCars[i]
                                                          .id) ??
                                              false
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      provider
                                          .addToCart(provider.AvailableCars[i]);
                                    },
                                    icon: Icon(Icons.shopping_cart_outlined),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
