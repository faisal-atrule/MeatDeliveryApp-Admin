import 'package:flutter/material.dart';
import '../../../helper_methods/helper_methods.dart';
import '../../../models/order_model.dart';
import '../../../resources/asset_res.dart';
import '../../../resources/color_res.dart';
import '../../../widgets/common_statistics_widget.dart';
import '../../../widgets/my_image_widgets.dart';
import '../../../widgets/orders_widget.dart';
import '../catalog/product/products_screen.dart';
import '../catalog/product_category/product_category_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function() goToAllOrdersScreen;
  final Function refreshHomeScreen;
  const HomeScreen({super.key, required this.goToAllOrdersScreen, required this.refreshHomeScreen});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget headingWidget({
    required IconData iconData,
    required String heading,
    bool? viewAllButtonVisible,
    Function()? onPressed
  }){
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                iconData,
                size: 24,
                color: ColorRes.primaryColor,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  heading,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              if(viewAllButtonVisible ?? false)
                TextButton(
                    onPressed: onPressed ?? (){},
                    style: Theme.of(context).textButtonTheme.style?.copyWith(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10, vertical: 5))
                    ),
                    child: const Text("See All")
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: ColorRes.primaryColor,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
            height: 0.5,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    myAssetImage(
                        imagePath: AssetRes.onlineStoreImage,
                        width: MediaQuery.of(context).size.width * 0.5,
                        fit: BoxFit.contain
                    ),
                  ],
                ),
              ),
              headingWidget(
                iconData: Icons.insert_chart_outlined_rounded,
                heading: "Common Statistics"
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      FutureBuilder<int>(
                        future: getOrdersCount(),
                        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                          if (snapshot.hasData) {
                            return commonStatisticsWidget(
                                context: context,
                                value: snapshot.data.toString(),
                                heading: "Orders",
                                backgroundColor: ColorRes.greenColor,
                                isLoading: false,
                                onTap: (){
                                  widget.goToAllOrdersScreen.call();
                                }
                            );
                          }
                          else if (!snapshot.hasData) {
                            return commonStatisticsWidget(
                                context: context,
                                value: "0",
                                heading: "Orders",
                                backgroundColor: ColorRes.greenColor,
                                isLoading: true,
                                onTap: (){
                                  widget.goToAllOrdersScreen.call();
                                }
                            );
                          }
                          else if (snapshot.hasError) {
                            return Container();
                          }
                          return Container();
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      FutureBuilder<int>(
                        future: getAllProductsCount(),
                        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                          if (snapshot.hasData) {
                            return commonStatisticsWidget(
                                context: context,
                                value: snapshot.data.toString(),
                                heading: "Products",
                                backgroundColor: ColorRes.crimsonColor,
                                isLoading: false,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen(refreshHomeScreen: widget.refreshHomeScreen,)));
                                }
                            );
                          }
                          else if (!snapshot.hasData) {
                            return commonStatisticsWidget(
                                context: context,
                                value: "0",
                                heading: "Products",
                                backgroundColor: ColorRes.crimsonColor,
                                isLoading: true,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen(refreshHomeScreen: widget.refreshHomeScreen,)));
                                }
                            );
                          }
                          else if (snapshot.hasError) {
                            return Container();
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      FutureBuilder<int>(
                        future: getProductCategoriesCount(),
                        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                          if (snapshot.hasData) {
                            return commonStatisticsWidget(
                                context: context,
                                value: snapshot.data.toString(),
                                heading: "Product Categories",
                                backgroundColor: ColorRes.orangeColor,
                                isLoading: false,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCategoryScreen(refreshHomeScreen: widget.refreshHomeScreen,)));
                                }
                            );
                          }
                          else if (!snapshot.hasData) {
                            return commonStatisticsWidget(
                                context: context,
                                value: "0",
                                heading: "Product Categories",
                                backgroundColor: ColorRes.orangeColor,
                                isLoading: true,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCategoryScreen(refreshHomeScreen: widget.refreshHomeScreen,)));
                                }
                            );
                          }
                          else if (snapshot.hasError) {
                            return Container();
                          }
                          return Container();
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(),
                      )
                    ],
                  ),
                ),
              ),
              headingWidget(
                iconData: Icons.shopping_bag_outlined,
                heading: "Latest Orders",
                viewAllButtonVisible: true,
                onPressed: (){
                  widget.goToAllOrdersScreen.call();
                }
              ),
              FutureBuilder<List<OrderModel>?>(
                future: getAllOrders(),
                builder: (BuildContext context, AsyncSnapshot<List<OrderModel>?> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)
                        ),
                        color: ColorRes.smokeWhiteColor,
                      ),
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          itemBuilder: (BuildContext builderContext, int builderIndex){
                            OrderModel? orderModel = snapshot.data?[builderIndex];
                            return orderModel != null ?
                            ordersWidget(
                              context: context,
                              orderModel: orderModel,
                              builderIndex: builderIndex,
                              length: (snapshot.data?.length ?? 0),
                              selectedOrderStatus: getSelectedStatus(orderStatus: orderModel.orderStatus),
                              changeStatus: (selectedStatus){
                                changeOrderStatus(
                                  builderIndex: builderIndex,
                                  status: selectedStatus,
                                  refreshFunction: (){setState(() {});}
                                );
                              }
                            ) : Container();
                          },
                          separatorBuilder: (BuildContext separatorContext, int separatorIndex){
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: snapshot.data?.length ?? 0
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                        color: ColorRes.primaryColor
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}