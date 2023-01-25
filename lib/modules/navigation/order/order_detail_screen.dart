import 'package:flutter/material.dart';

import '../../../../resources/color_res.dart';
import '../../../../widgets/my_app_bar.dart';
import '../../../models/order_model.dart';
import '../../../widgets/order_detail_cart_widget.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderModel orderDetailModel;
  const OrderDetailScreen({super.key, required this.orderDetailModel});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          title: "Order # ${widget.orderDetailModel.orderId}",
          centerTitle: true,
          backgroundColor: ColorRes.whiteColor,
          isLeadingIcon: true,
          icon: Icons.arrow_back_ios_new_rounded,
          onPressed: (){
            Navigator.pop(context);
          },
          list: []
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Address",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                      color: ColorRes.smokeWhiteColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${widget.orderDetailModel.orderDeliveryAddress.addressFirstName} ${widget.orderDetailModel.orderDeliveryAddress.addressLastName}",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${widget.orderDetailModel.orderDeliveryAddress.addressEmail} | ${widget.orderDetailModel.orderDeliveryAddress.addressPhoneNumber}",
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.orderDetailModel.orderDeliveryAddress.addressDetails ?? "",
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Payment",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10)
                      ),
                      color: ColorRes.smokeWhiteColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.orderDetailModel.orderPaymentMethodName,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  if(widget.orderDetailModel.orderProducts.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Order Items",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          )
                        ],
                      ),
                    ),
                  orderDetailCartWidget(
                    context: context,
                    orderDetailModel: widget.orderDetailModel
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}