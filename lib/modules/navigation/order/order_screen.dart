import 'package:flutter/material.dart';
import '../../../helper_methods/helper_methods.dart';
import '../../../models/order_model.dart';
import '../../../resources/color_res.dart';
import '../../../resources/string_res.dart';
import '../../../widgets/my_app_bar.dart';
import '../../../widgets/orders_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          title: StringRes.orderManagementTitle,
          centerTitle: true,
          backgroundColor: ColorRes.whiteColor,
          isLeadingIcon: false,
          icon: Icons.arrow_back_ios_new_rounded,
          onPressed: () {},
          list: []
      ),
      body: SafeArea(
        child: FutureBuilder<List<OrderModel>?>(
          future: getAllOrders(),
          builder: (BuildContext context, AsyncSnapshot<List<OrderModel>?> snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: const EdgeInsets.all(20),
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
        ),
      ),
    );
  }
}