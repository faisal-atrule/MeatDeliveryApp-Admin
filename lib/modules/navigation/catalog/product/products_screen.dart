import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../helper_methods/helper_methods.dart';
import '../../../../models/product_model.dart';
import '../../../../resources/color_res.dart';
import '../../../../resources/string_res.dart';
import '../../../../widgets/my_app_bar.dart';
import '../../../../widgets/my_image_widgets.dart';
import 'add_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  final Function refreshHomeScreen;
  const ProductsScreen({super.key, required this.refreshHomeScreen});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  static const double imageSize = 70;
  static const double imagePadding = 2;
  static const double deleteIconPadding = 20;
  static const double deleteIconSize = 24;

  Widget productDetails({
    required String title,
    required String value,
    double? topMargin
  }){
    return Container(
      margin: EdgeInsets.only(top: (topMargin?.toDouble() ?? 0)),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(
                        text: "$title: ",
                        style: Theme.of(context).textTheme.bodyLarge
                    ),
                    TextSpan(
                        text: value,
                        style: Theme.of(context).textTheme.displayLarge
                    )
                  ]
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          title: StringRes.productTitle,
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
              onPressed: () async {
                await showLoading();

                getAllCategories().then((value) async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen(editProductModel: null, categories: value ?? [], refreshProductsScreen: (){
                    setState(() {});
                    widget.refreshHomeScreen.call();
                    })));
                  await hideLoading();
                });
              },
            )
          ]
      ),
      body: SafeArea(
        child: FutureBuilder<List<ProductModel>?>(
          future: getAllProducts(),
          builder: (BuildContext context, AsyncSnapshot<List<ProductModel>?> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (BuildContext builderContext, int builderIndex){
                    ProductModel? productModel = snapshot.data?[builderIndex];
                    return productModel != null ?
                    GestureDetector(
                      onTap: () async {
                        await showLoading();

                        getAllCategories().then((value) async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen(editProductModel: productModel, categories: value ?? [], refreshProductsScreen: (){
                            setState(() {});
                            widget.refreshHomeScreen.call();
                            },)));
                          await hideLoading();
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: ((imageSize + imagePadding) / 2), right: ((deleteIconSize + deleteIconPadding) / 2)),
                            padding: const EdgeInsets.only(left: (((imageSize + imagePadding) / 2) + 10), right: (((deleteIconSize + deleteIconPadding) / 2) + 10), top: 10, bottom: 10),
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                productDetails(
                                  title: "Name",
                                  value: productModel.name
                                ),
                                productDetails(
                                  title: "Detail",
                                  value: productModel.details,
                                  topMargin: 10
                                ),
                                productDetails(
                                    title: "Price",
                                    value: "\$ ${productModel.price}",
                                    topMargin: 10
                                ),
                                productDetails(
                                    title: "Category",
                                    value: getCategoryNameFromId(productModel.categoryId),
                                    topMargin: 10
                                ),
                                productDetails(
                                    title: productModel.attributes?.attributeName ?? "",
                                    value: getAttributesNames(productModel.attributes?.attributeValues ?? []),
                                    topMargin: 10
                                )
                              ],
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(imagePadding/2),
                                clipBehavior: Clip.antiAlias,
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
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: myMemoryImage(
                                      imagePath: base64Decode(productModel.imageUrl[0]),
                                      width: imageSize,
                                      height: imageSize,
                                    fit: BoxFit.cover
                                  ),
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
                                        deleteProduct(productModel: productModel);

                                        if(mounted){
                                          setState(() {});
                                        }

                                        widget.refreshHomeScreen.call();
                                      }
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(deleteIconPadding/2),
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