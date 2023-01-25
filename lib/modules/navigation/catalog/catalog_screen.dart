import 'package:flutter/material.dart';
import '../../../resources/color_res.dart';
import '../../../resources/string_res.dart';
import '../../../widgets/menu_container.dart';
import '../../../widgets/my_app_bar.dart';
import 'product/products_screen.dart';
import 'product_category/product_category_screen.dart';

class CatalogScreen extends StatefulWidget {
  final Function refreshHomeScreen;
  const CatalogScreen({super.key, required this.refreshHomeScreen});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          title: StringRes.catalogManagementTitle,
          centerTitle: true,
          backgroundColor: ColorRes.whiteColor,
          isLeadingIcon: false,
          icon: Icons.arrow_back_ios_new_rounded,
          onPressed: () {},
          list: []
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCategoryScreen(refreshHomeScreen: widget.refreshHomeScreen,)));
                    },
                    child: menuContainer(
                      context: context,
                      menuTitle: StringRes.categoryTitle
                    )
                ),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen(refreshHomeScreen: widget.refreshHomeScreen,)));
                    },
                    child: menuContainer(
                      context: context,
                      menuTitle: StringRes.productTitle,
                      topMargin: 20
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}