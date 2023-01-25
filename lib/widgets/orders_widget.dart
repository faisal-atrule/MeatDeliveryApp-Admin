import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order_model.dart';
import '../modules/navigation/order/order_detail_screen.dart';
import '../resources/color_res.dart';
import '../resources/string_res.dart';
import 'bottom_sheet_bar.dart';
import 'bottom_sheet_decoration.dart';

Widget ordersWidget({
  required BuildContext context,
  required OrderModel orderModel,
  required int builderIndex,
  required int length,
  required String selectedOrderStatus,
  required Function(String value) changeStatus
}){
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailScreen(orderDetailModel: orderModel)));
    },
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.3
          ),
          padding: const EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                  Radius.circular(10)
              ),
              color: ColorRes.greenColor
          ),
          child: Text(
              "# ${orderModel.orderId}",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorRes.whiteColor)
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Order total: ",
                                  style: Theme.of(context).textTheme.bodyLarge
                              ),
                              TextSpan(
                                  text: "\$${orderModel.orderTotal}",
                                  style: Theme.of(context).textTheme.displayLarge
                              )
                            ]
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Order status: ",
                                    style: Theme.of(context).textTheme.bodyLarge
                                ),
                                TextSpan(
                                    text: orderModel.orderStatus,
                                    style: Theme.of(context).textTheme.displayLarge
                                )
                              ]
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          attributeValueBottomSheet(
                            context: context,
                            selectedOrderStatus: selectedOrderStatus,
                            changeStatus: changeStatus
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 3),
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: const BoxDecoration(
                            color: ColorRes.goldColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: const Icon(Icons.change_circle_outlined, size: 18, color: ColorRes.whiteColor,)
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: "Placed on: ",
                                    style: Theme.of(context).textTheme.bodyLarge
                                ),
                                TextSpan(
                                    text: orderModel.orderPlaceDate != null ? DateFormat.yMMMMd().format(orderModel.orderPlaceDate!) : "",
                                    style: Theme.of(context).textTheme.displayLarge
                                )
                              ]
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if(builderIndex < (length - 1))
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Divider(
                      height: 0.5,
                      thickness: 0.5,
                      color: ColorRes.primaryColor.withOpacity(0.3),
                    ),
                  )
              ]
          ),
        ),
      ],
    ),
  );
}

attributeValueBottomSheet({
  required BuildContext context,
  required String selectedOrderStatus,
  required Function(String value) changeStatus
}){
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bottomSheetContext) {
      return StatefulBuilder(builder: (context, setState) {
        return SingleChildScrollView(
          child: bottomSheetDecoration(
            context: bottomSheetContext,
            child: Column(
              children: [
                bottomSheetBar(
                    context: context
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Order Status",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      width: 0.5,
                      color: ColorRes.primaryColor,
                    ),
                  ),
                  child: DropdownButton<String>(
                    alignment: Alignment.center,
                    hint:  SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Select order status",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorRes.primaryLightColor
                        ),
                      ),
                    ),
                    focusColor: Colors.transparent,
                    value: selectedOrderStatus,
                    isExpanded: true,
                    isDense: true,
                    dropdownColor: ColorRes.whiteColor,
                    style: Theme.of(context).textTheme.bodyMedium,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 24, color: ColorRes.primaryColor),
                    underline: Container(),
                    onChanged: (String? value) {
                      setState(() {
                        if(value != null){
                          selectedOrderStatus = value;
                          changeStatus.call(value);
                        }
                      });
                    },
                    items: StringRes.orderStatuses.map((String position) {
                      return  DropdownMenuItem<String>(
                        value: position,
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            position,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            )
          ),
        );
      });
    },
  );
}