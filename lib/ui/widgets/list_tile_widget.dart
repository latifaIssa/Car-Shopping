import 'package:car_shopping/services/colors.dart';
import 'package:car_shopping/services/routes.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  String label;
  IconData icon;
  String routeName;

  ListTileWidget({this.label, this.icon, this.routeName});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        onTap: () {
          RouteHelper.routeHelper.goToPage(routeName);
        },
      ),
    );
  }
}
