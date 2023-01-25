import 'package:flutter/material.dart';

import 'account/account_screen.dart';
import 'home/home_screen.dart';
import 'order/order_screen.dart';
import 'catalog/catalog_screen.dart';

List<Widget> getBottomNavigationList({
  required Function() refreshFunction,
  required Function() goToOrdersScreen
}){
  return <Widget>[
    HomeScreen(goToAllOrdersScreen: goToOrdersScreen, refreshHomeScreen: refreshFunction,),
    const OrderScreen(),
    CatalogScreen(refreshHomeScreen: refreshFunction,),
    const AccountScreen()
  ];
}