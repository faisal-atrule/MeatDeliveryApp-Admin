import 'dart:convert';

import 'package:flutter/material.dart';
import '../helper_methods/helper_methods.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../resources/color_res.dart';
import 'my_image_widgets.dart';
import 'sub_total_widget.dart';

Widget orderDetailCartWidget({
  required BuildContext context,
  required OrderModel orderDetailModel
}){
  return Column(
    children: [
      ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext builderContext, int builderIndex){
            ProductModel productModel = orderDetailModel.orderProducts[builderIndex];
            return Container(
              padding: const EdgeInsets.all(10),
              color: ColorRes.whiteColor,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10)
                      ),
                      child: myMemoryImage(
                          imagePath: base64Decode(productModel.imageUrl[0]),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.3,
                          fit: BoxFit.cover
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    productModel.name.toString(),
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "\$ ${productModel.price} (${productModel.quantity})",
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if(getSelectedAttribute(productModel: productModel) != "")
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        getSelectedAttribute(productModel: productModel),
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext separatorContext, int separatorIndex){
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Divider(
                height: 0.5,
                thickness: 0.5,
                color: ColorRes.primaryColor.withOpacity(0.3),
              ),
            );
          },
          itemCount: orderDetailModel.orderProducts.length
      ),
      if(orderDetailModel.orderProducts.isNotEmpty)
        Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              subTotalWidget(
                  context: context,
                  title: "Sub Total",
                  value: "\$ ${orderDetailModel.orderSubTotal}",
                  prominentLeft: false,
                  prominentRight: true
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: subTotalWidget(
                      context: context,
                      title: "Discount",
                      value: "-\$ ${orderDetailModel.orderDiscount}",
                      prominentLeft: false,
                      prominentRight: true
                  )
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: subTotalWidget(
                    context: context,
                    title: "Est. Tax",
                    value: "\$ ${orderDetailModel.orderTax}",
                    prominentLeft: false,
                    prominentRight: true
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: subTotalWidget(
                    context: context,
                    title: "Delivery",
                    value: orderDetailModel.orderDeliveryFee.toString(),
                    prominentLeft: false,
                    prominentRight: true
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: ColorRes.darkGreyColor,
                ),
              ),

              Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: subTotalWidget(
                      context: context,
                      title: "Total Payable",
                      value: "\$ ${orderDetailModel.orderTotal}",
                      prominentLeft: true,
                      prominentRight: true
                  )
              ),
            ],
          ),
        )
    ],
  );
}