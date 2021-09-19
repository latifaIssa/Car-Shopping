import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_shopping/models/car_response_model.dart';
import 'package:car_shopping/providers/car_provider.dart';
import 'package:car_shopping/services/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  static final routeName = 'favourite';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      appBar: AppBar(
        title: Text('Favourite'),
      ),
      body: Consumer<CarProvider>(
        builder: (context, provider, x) {
          List<CarResponse> products = provider.favouriteProducts;
          return products == null
              ? Center(
                  child: Text('No Favourites'),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                'https://stat.overdrive.in/wp-content/odgallery/2020/06/57263_2020_Mercedes_Benz_GLS.jpg'),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  provider
                                      .deleteFromFavourite(products[index].id);
                                },
                                icon: Icon(Icons.delete)),
                          ),
                        ))
                      ],
                    );
                  });
        },
      ),
    );
  }
}
