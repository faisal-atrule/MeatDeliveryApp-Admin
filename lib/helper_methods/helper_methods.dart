import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/local/my_local_storage.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/top_menu_model.dart';
import '../modules/login/login_screen.dart';
import '../modules/navigation/navigation_screen.dart';
import '../resources/asset_res.dart';
import '../resources/color_res.dart';
import '../resources/string_res.dart';
import '../utilities/my_validator.dart';

convertStatusBarToWhite(){
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorRes.whiteColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark
  ));
}

Future<void> moveNextFromSplashScreen(BuildContext context) async {
  final navigator = Navigator.of(context);
  if(await MyLocalStorage.instance.getBool(MyLocalStorage.isAdminLogin)){
    navigator.pushReplacement(MaterialPageRoute(builder: (_) => const NavigationScreen(index: 0,),));
  }
  else{
    navigator.pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen(),));
  }
}

int getOrderCount(){
  return 0;
}

int getProductCount(){
  return 0;
}

String? textValidator({
  required String? value,
  required String errorMessage
}){
  if(value != null){
    if(value.isEmpty || value.trim() == ""){
      return errorMessage;
    }
    else{
      return null;
    }
  }
  else{
    return errorMessage;
  }
}

String? doubleValueValidator({
  required String? value,
  required String invalidMessage,
  required String emptyMessage
}){
  if(value != null){
    if(value.isEmpty || value.trim() == ""){
      return emptyMessage;
    }
    else if(double.tryParse(value) == null){
      return invalidMessage;
    }
    else{
      return null;
    }
  }
  else{
    return emptyMessage;
  }
}

String? emailValidator({
  required String? value,
  required String invalidMessage,
  required String emptyMessage
}){
  if(value != null){
    if(value.isEmpty || value.trim() == ""){
      return emptyMessage;
    }
    else if(!MyValidator.instance.isEmail(value)){
      return invalidMessage;
    }
    else{
      return null;
    }
  }
  else{
    return emptyMessage;
  }
}

String? passwordValidator({
  required String? value,
  required String invalidMessage,
  required String emptyMessage
}){
  if(value != null){
    if(value.isEmpty || value.trim() == ""){
      return emptyMessage;
    }
    else if(value.length != 6){
      return invalidMessage;
    }
    else{
      return null;
    }
  }
  else{
    return emptyMessage;
  }
}

alertDialog({
  required BuildContext context,
  required String alertMessage,
  IconData? icon
}){
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext dialogContext){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          backgroundColor: ColorRes.whiteColor,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2,
                            color: ColorRes.greenColor
                        )
                    ),
                    child: Icon(
                      icon ?? Icons.priority_high_outlined,
                      size: 24,
                      color: ColorRes.greenColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            alertMessage,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Divider(
                      height: 0.2,
                      thickness: 0.2,
                      color: ColorRes.darkGreyColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Material(
                            color: ColorRes.greenColor,
                            shape: const StadiumBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              focusColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              highlightColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              hoverColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              splashColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              onTap: (){
                                Navigator.pop(dialogContext);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Text(
                                  "Got It",
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorRes.whiteColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

openSettingsDialog({
  required BuildContext context,
  required String alertMessage
}){
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext dialogContext){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          backgroundColor: ColorRes.whiteColor,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          alertMessage,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Divider(
                      height: 0.2,
                      thickness: 0.2,
                      color: ColorRes.darkGreyColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Material(
                            color: ColorRes.greenColor,
                            shape: const StadiumBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              focusColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              highlightColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              hoverColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              splashColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              onTap: (){
                                Navigator.pop(dialogContext);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Text(
                                  "Cancel",
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorRes.whiteColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Material(
                            color: ColorRes.greenColor,
                            shape: const StadiumBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              focusColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              highlightColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              hoverColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              splashColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              onTap: () async {
                                Navigator.pop(dialogContext);
                                await openAppSettings();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Text(
                                  "Open",
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorRes.whiteColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

Future<int> getAllProductsCount() async {
  if(StringRes.products.isEmpty){
    try{
      String data = await rootBundle.loadString(AssetRes.jsonData);
      var jsonData = json.decode(data);
      StringRes.products.clear();
      StringRes.products.addAll(List<ProductModel>.from(jsonData["productsData"].map((x) => ProductModel.fromJson(x))));
    }catch(exception){
      StringRes.products.clear();
    }
  }

  return StringRes.products.length;
}

Future<int> getOrdersCount() async {
  if(StringRes.orders.isEmpty){
    try{
      String data = await rootBundle.loadString(AssetRes.jsonData);
      var jsonData = json.decode(data);
      StringRes.orders.clear();
      StringRes.orders.addAll(List<OrderModel>.from(jsonData["orders"].map((x) => OrderModel.fromJson(x))));
    }catch(exception){
      StringRes.orders.clear();
    }
  }

  return StringRes.orders.length;
}

Future<int> getProductCategoriesCount() async {
  if(StringRes.productCategories.isEmpty){
    try{
      String data = await rootBundle.loadString(AssetRes.jsonData);
      var jsonData = json.decode(data);
      StringRes.productCategories.clear();
      StringRes.productCategories.addAll(List<TopMenuModel>.from(jsonData["topMenuModel"].map((x) => TopMenuModel.fromJson(x))));
    }catch(exception){
      StringRes.productCategories.clear();
    }
  }

  return StringRes.productCategories.length;
}

Future<List<TopMenuModel>?> getAllCategories() async {
  if(StringRes.productCategories.isEmpty){
    try{
      String data = await rootBundle.loadString(AssetRes.jsonData);
      var jsonData = json.decode(data);
      StringRes.productCategories.clear();
      StringRes.productCategories.addAll(List<TopMenuModel>.from(jsonData["topMenuModel"].map((x) => TopMenuModel.fromJson(x))));
    }catch(exception){
      StringRes.productCategories.clear();
    }
  }

  return StringRes.productCategories;
}

Future<String> checkCameraPermission(BuildContext context) async {
  String bytes = "";

  PermissionStatus permissionStatus = await Permission.camera.request();
  if(permissionStatus == PermissionStatus.granted){
    bytes = await myImagePickerFunction(ImageSource.camera, context);
  }
  else{
    openSettingsDialog(
      context: context,
      alertMessage: "This feature requires camera permission and you have denied it. Press open to allow permission from settings."
    );
  }

  return bytes;
}

Future<String> checkStoragePermissionForGallery(BuildContext context) async {
  String bytes = "";

  PermissionStatus permissionStatus = await Permission.storage.request();
  if(permissionStatus == PermissionStatus.granted){
    bytes = await myImagePickerFunction(ImageSource.gallery, context);
  }
  else{
    openSettingsDialog(
        context: context,
        alertMessage: "This feature requires storage permission and you have denied it. Press open to allow permission from settings."
    );
  }

  return bytes;
}

Future<String> myImagePickerFunction(ImageSource source, BuildContext context) async {
  String bytes = "";

  try{
    await showLoading();

    XFile? image = await ImagePicker().pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.front
    );

    if(image != null){
      File imageFile = File(image.path);
      String imageBytesStringEncoded = base64Encode(imageFile.readAsBytesSync());
      bytes = imageBytesStringEncoded;
    }
    else{
      alertDialog(
          context: context,
          alertMessage: "Couldn't pick image."
      );
    }
  }catch(exception){
    alertDialog(
      context: context,
      alertMessage: "Couldn't pick image."
    );
  }finally{
    await hideLoading();
  }

  return bytes;
}

Future showLoading() async {
  await EasyLoading.show(status: "Please wait...");
}

Future hideLoading() async {
  await EasyLoading.dismiss();
}

bool saveNewProductCategory({
  required TopMenuModel topMenuModel
}){
  if(StringRes.productCategories.isEmpty){
    topMenuModel.id = 0;
  }
  else{
    topMenuModel.id = StringRes.productCategories.last.id + 1;
  }

  StringRes.productCategories.add(topMenuModel);

  return true;
}

bool editProductCategory({
  required TopMenuModel topMenuModel
}){
  int index = StringRes.productCategories.indexWhere((element) => element.id == topMenuModel.id);
  StringRes.productCategories[index] = topMenuModel;

  return true;
}

bool deleteProductCategory({
  required TopMenuModel topMenuModel
}){
  StringRes.productCategories.removeWhere((element) => element.id == topMenuModel.id);
  return true;
}

bool saveNewProduct({
  required ProductModel productModel
}){
  if(StringRes.products.isEmpty){
    productModel.id = 0;
  }
  else{
    productModel.id = StringRes.products.last.id + 1;
  }

  StringRes.products.add(productModel);

  return true;
}

bool editProduct({
  required ProductModel productModel
}){
  int index = StringRes.products.indexWhere((element) => element.id == productModel.id);
  StringRes.products[index] = productModel;

  return true;
}

bool deleteProduct({
  required ProductModel productModel
}){
  StringRes.products.removeWhere((element) => element.id == productModel.id);
  return true;
}

deleteDialog({
  required BuildContext context,
  required Function() deleteFunction
}){
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext dialogContext){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          backgroundColor: ColorRes.whiteColor,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2,
                            color: ColorRes.crimsonColor
                        )
                    ),
                    child: const Icon(
                      Icons.clear_rounded,
                      size: 24,
                      color: ColorRes.crimsonColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Are you sure?",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Do you really want to delete it?\nYou can't undo this action.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Divider(
                      height: 0.2,
                      thickness: 0.2,
                      color: ColorRes.darkGreyColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Material(
                            color: ColorRes.primaryColor,
                            shape: const StadiumBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              focusColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              highlightColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              hoverColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              splashColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              onTap: (){
                                Navigator.pop(dialogContext);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Text(
                                  "Cancel".toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorRes.whiteColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Material(
                            color: ColorRes.crimsonColor,
                            shape: const StadiumBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              focusColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              highlightColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              hoverColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              splashColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              onTap: (){
                                Navigator.pop(dialogContext);
                                deleteFunction.call();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Text(
                                  "Delete".toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorRes.whiteColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

logoutDialog({
  required BuildContext context,
  required Function() logoutFunction
}){
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext dialogContext){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          backgroundColor: ColorRes.whiteColor,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2,
                            color: ColorRes.crimsonColor
                        )
                    ),
                    child: const Icon(
                      Icons.logout_rounded,
                      size: 24,
                      color: ColorRes.crimsonColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Are you sure?",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Do you really want to logout.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Divider(
                      height: 0.2,
                      thickness: 0.2,
                      color: ColorRes.darkGreyColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Material(
                            color: ColorRes.primaryColor,
                            shape: const StadiumBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              focusColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              highlightColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              hoverColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              splashColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              onTap: (){
                                Navigator.pop(dialogContext);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Text(
                                  "No, cancel".toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorRes.whiteColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Material(
                            color: ColorRes.crimsonColor,
                            shape: const StadiumBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              focusColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              highlightColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              hoverColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              splashColor: ColorRes.darkGreyColor.withOpacity(0.1),
                              onTap: (){
                                Navigator.pop(dialogContext);
                                logoutFunction.call();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Text(
                                  "Logout".toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorRes.whiteColor
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

Future<List<ProductModel>?> getAllProducts() async {
  await getAllCategories();

  if(StringRes.products.isEmpty){
    try{
      String data = await rootBundle.loadString(AssetRes.jsonData);
      var jsonData = json.decode(data);
      StringRes.products.clear();
      StringRes.products.addAll(List<ProductModel>.from(jsonData["productsData"].map((x) => ProductModel.fromJson(x))));
    }catch(exception){
      StringRes.products.clear();
    }
  }

  return StringRes.products;
}

Future<List<OrderModel>?> getAllOrders() async {
  if(StringRes.orders.isEmpty){
    try{
      String data = await rootBundle.loadString(AssetRes.jsonData);
      var jsonData = json.decode(data);
      StringRes.orders.clear();
      StringRes.orders.addAll(List<OrderModel>.from(jsonData["orders"].map((x) => OrderModel.fromJson(x))));
    }catch(exception){
      StringRes.orders.clear();
    }
  }

  return StringRes.orders;
}

changeOrderStatus({
  required int builderIndex,
  required String status,
  required Function refreshFunction
}){
  StringRes.orders[builderIndex].orderStatus = status;
  refreshFunction.call();
}

String getCategoryNameFromId(int id){
  try{
    return StringRes.productCategories[StringRes.productCategories.indexWhere((element) => element.id == id)].title;
  }catch(exception){
    return "";
  }
}

String getAttributesNames(List<AttributeValue> list){
  String returnValue = "";

  for (var element in list) {
    if(returnValue == ""){
      returnValue = element.attributeValueName;
    }
    else{
      returnValue = "$returnValue, ${element.attributeValueName}";
    }
  }

  return returnValue;
}

String getSelectedAttribute({
  required ProductModel productModel
}){
  String value = "";

  if(productModel.attributes != null){
    for (var element in productModel.attributes!.attributeValues) {
      if(element.attributeValueSelected){
        value = element.attributeValueName;
      }
    }
  }
  return value;
}

String getSelectedStatus({
  required String orderStatus
}){
  String selectedStatus = "";

  for (var element in StringRes.orderStatuses) {
    if(element == orderStatus){
      selectedStatus = element;
    }
  }

  return selectedStatus;
}