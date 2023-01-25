import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../helper_methods/helper_methods.dart';
import '../../../../models/top_menu_model.dart';
import '../../../../resources/color_res.dart';
import '../../../../resources/string_res.dart';
import '../../../../widgets/my_app_bar.dart';
import '../../../../widgets/my_image_widgets.dart';
import 'add_product_category_screen.dart';

class ProductCategoryScreen extends StatefulWidget {
  final Function refreshHomeScreen;
  const ProductCategoryScreen({super.key, required this.refreshHomeScreen});

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  static const double imageSize = 50;
  static const double imagePadding = 20;
  static const double deleteIconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          title: StringRes.categoryTitle,
          centerTitle: false,
          backgroundColor: ColorRes.whiteColor,
          isLeadingIcon: true,
          icon: Icons.arrow_back_ios_new_rounded,
          onPressed: (){
            Navigator.pop(context);
          },
          list: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductCategoryScreen(editMenuModel: null, refreshCategoriesScreen: (){
                  setState(() {});
                  widget.refreshHomeScreen.call();
                  },)));
              },
            )
          ]
      ),
      body: SafeArea(
        child: FutureBuilder<List<TopMenuModel>?>(
          future: getAllCategories(),
          builder: (BuildContext context, AsyncSnapshot<List<TopMenuModel>?> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (BuildContext builderContext, int builderIndex){
                    TopMenuModel? topMenuModel = snapshot.data?[builderIndex];
                    return topMenuModel != null ?
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductCategoryScreen(editMenuModel: topMenuModel, refreshCategoriesScreen: (){
                          setState(() {});
                          widget.refreshHomeScreen.call();
                          },)));
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: ((imageSize + imagePadding) / 2), right: ((deleteIconSize + imagePadding) / 2)),
                            padding: const EdgeInsets.only(left: (((imageSize + imagePadding) / 2) + 10), right: (((deleteIconSize + imagePadding) / 2) + 10), top: 10, bottom: 10),
                            constraints: const BoxConstraints(
                              minHeight: (imageSize + imagePadding + 40)
                            ),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [BoxShadow(
                                  color: ColorRes.darkGreyColor.withOpacity(0.2),
                                  spreadRadius: 0.3,
                                  blurRadius: 1,
                                  offset: const Offset(0, 0),
                                )],
                                color: ColorRes.whiteColor
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    topMenuModel.title,
                                    style: Theme.of(context).textTheme.displayLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(imagePadding/2),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [BoxShadow(
                                      color: ColorRes.darkGreyColor.withOpacity(0.2),
                                      spreadRadius: 0.3,
                                      blurRadius: 1,
                                      offset: const Offset(0, 0),
                                    )],
                                    color: ColorRes.smokeWhiteColor
                                ),
                                child: myMemoryImage(
                                  imagePath: base64Decode(topMenuModel.iconPath),
                                  width: imageSize,
                                  height: imageSize
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: (){
                                  deleteDialog(
                                    context: context,
                                    deleteFunction: (){
                                      deleteProductCategory(topMenuModel: topMenuModel);

                                      if(mounted){
                                        setState(() {});
                                      }

                                      widget.refreshHomeScreen.call();
                                    }
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(imagePadding/2),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [BoxShadow(
                                        color: ColorRes.darkGreyColor.withOpacity(0.2),
                                        spreadRadius: 0.3,
                                        blurRadius: 1,
                                        offset: const Offset(0, 0),
                                      )],
                                      color: ColorRes.smokeWhiteColor
                                  ),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    size: deleteIconSize,
                                    color: ColorRes.crimsonColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ) :
                    Container();
                  },
                  separatorBuilder: (BuildContext separatorContext, int separatorIndex){
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: snapshot.data?.length ?? 0
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                  color: ColorRes.primaryColor
              ),
            );
          },
        ),
      ),
    );
  }
}