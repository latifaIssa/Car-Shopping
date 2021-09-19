import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_shopping/models/car_response_model.dart';
import 'package:car_shopping/providers/car_provider.dart';
import 'package:car_shopping/services/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static final routeName = 'cart';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Palette.primary,
      ),
      body: Consumer<CarProvider>(
        builder: (context, provider, x) {
          List<CarResponse> products = provider.cartProducts;
          return products == null
              ? Center(
                  child: Text('No Carts'),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.white,
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://stat.overdrive.in/wp-content/odgallery/2020/06/57263_2020_Mercedes_Benz_GLS.jpg',
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  products[index].car +
                                      ' ' +
                                      products[index].carModel,
                                  softWrap: true,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Price: ' +
                                      products[index].price.toString() +
                                      '\$',
                                  softWrap: true,
                                ),
                              ),
                              // Spacer(),
                              Container(
                                child: Text(
                                  'Quantity: ' +
                                      products[index].quantity.toString(),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }
}
