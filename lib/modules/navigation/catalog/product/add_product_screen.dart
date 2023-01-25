import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../../helper_methods/helper_methods.dart';
import '../../../../models/product_model.dart';
import '../../../../models/top_menu_model.dart';
import '../../../../resources/color_res.dart';
import '../../../../resources/string_res.dart';
import '../../../../widgets/bottom_sheet_bar.dart';
import '../../../../widgets/bottom_sheet_decoration.dart';
import '../../../../widgets/my_app_bar.dart';
import '../../../../widgets/my_image_widgets.dart';
import '../../../../widgets/my_input_decoration.dart';
import '../../../../widgets/my_input_field.dart';

class AddProductScreen extends StatefulWidget {
  final ProductModel? editProductModel;
  final List<TopMenuModel> categories;
  final Function refreshProductsScreen;
  const AddProductScreen({super.key, required this.editProductModel, required this.categories, required this.refreshProductsScreen});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> attributeValueFormKey = GlobalKey<FormState>();

  TextEditingController productNameController = TextEditingController();
  FocusNode productNameFocusNode = FocusNode();

  TextEditingController productDetailController = TextEditingController();
  FocusNode productDetailFocusNode = FocusNode();

  TextEditingController productPriceController = TextEditingController();
  FocusNode productPriceFocusNode = FocusNode();

  TextEditingController productAttributeTitleController = TextEditingController();
  FocusNode productAttributeTitleFocusNode = FocusNode();

  TextEditingController productAttributeValueController = TextEditingController();
  FocusNode productAttributeValueFocusNode = FocusNode();

  List<String> imagePaths = [];

  List<AttributeValue> attributeValues = [];

  TopMenuModel? selectedCategory;

  getImageFromCamera({
    required bool edit,
    required int index
  }) async {
    String returnPath = await checkCameraPermission(context);

    if(returnPath != ""){
      if(edit){
        imagePaths[index] = returnPath;
      }
      else{
        imagePaths.add(returnPath);
      }

      if(mounted){
        setState(() {});
      }
    }
  }

  getImageFromGallery({
    required bool edit,
    required int index
  }) async {
    String returnPath = await checkStoragePermissionForGallery(context);

    if(returnPath != ""){
      if(edit){
        imagePaths[index] = returnPath;
      }
      else{
        imagePaths.add(returnPath);
      }

      if(mounted){
        setState(() {});
      }
    }
  }

  attributeValueBottomSheet({
    required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool Function() onPress
  }){
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bottomSheetContext) {
        return SingleChildScrollView(
          child: bottomSheetDecoration(
            context: bottomSheetContext,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  bottomSheetBar(
                      context: context
                  ),
                  titleTextWidget(
                    title: "Attribute Value"
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: MyInputField(
                      controller: controller,
                      focusNode: focusNode,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: myInputDecoration(
                          context: context,
                          label: "",
                          hint: "Enter attribute value",
                          dense: true
                      ),
                      validator: (String? value){
                        return textValidator(
                            value: value,
                            errorMessage: "Please enter attribute value"
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextButton(
                        onPressed: (){
                          bool value = onPress.call();

                          if(value){
                            Navigator.pop(bottomSheetContext);
                          }
                        },
                        style: Theme.of(context).textButtonTheme.style,
                        child: const Text(StringRes.saveTitle)
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.editProductModel != null){
      setState(() {
        productNameController.value = TextEditingValue(text: widget.editProductModel!.name);
        productDetailController.value = TextEditingValue(text: widget.editProductModel!.details);
        productPriceController.value = TextEditingValue(text: widget.editProductModel!.price.toString());
        productAttributeTitleController.value = TextEditingValue(text: widget.editProductModel!.attributes?.attributeName ?? "");

        attributeValues.clear();
        attributeValues.addAll(widget.editProductModel?.attributes?.attributeValues ?? []);

        imagePaths.clear();
        imagePaths.addAll(widget.editProductModel!.imageUrl);

        for (var element in widget.categories) {
          if(element.id == widget.editProductModel!.categoryId){
            selectedCategory = element;
          }
        }
      });
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    productNameFocusNode.dispose();

    productDetailController.dispose();
    productDetailFocusNode.dispose();

    productPriceController.dispose();
    productPriceFocusNode.dispose();

    productAttributeTitleController.dispose();
    productAttributeTitleFocusNode.dispose();

    productAttributeValueController.dispose();
    productAttributeValueFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          title: widget.editProductModel == null ? StringRes.addProductTitle : StringRes.editProductTitle,
          centerTitle: false,
          backgroundColor: ColorRes.whiteColor,
          isLeadingIcon: true,
          icon: Icons.arrow_back_ios_new_rounded,
          onPressed: (){
            Navigator.pop(context);
          },
          list: []
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: productFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  titleTextWidget(
                    title: "Product Name"
                  ),
                  productsName(context: context),
                  titleTextWidget(
                    title: "Product Detail",
                    topMargin: 20
                  ),
                  productsDetail(context: context),
                  titleTextWidget(
                      title: "Product Price",
                      topMargin: 20
                  ),
                  productsPrice(context: context),
                  titleTextWidget(
                      title: "Product Attribute Title",
                      topMargin: 20
                  ),
                  productsAttributeTitle(context: context),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "Product Attribute Values",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: IconButton(
                            splashRadius: 24,
                            tooltip: "Add product attribute values",
                            onPressed: (){
                              productAttributeValueController.clear();

                              attributeValueBottomSheet(
                                formKey: attributeValueFormKey,
                                controller: productAttributeValueController,
                                focusNode: productAttributeValueFocusNode,
                                onPress: (){
                                  if (attributeValueFormKey.currentState?.validate() ?? false) {
                                    attributeValueFormKey.currentState?.save();

                                    setState(() {
                                      attributeValues.add(
                                          AttributeValue(
                                              attributeValueName: productAttributeValueController.text.toString(),
                                              attributeValueSelected: false
                                          )
                                      );
                                    });

                                    return true;
                                  }

                                  return false;
                                }
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 24,
                              color: ColorRes.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if(attributeValues.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: attributeValues.asMap().entries.map((e){
                        return GestureDetector(
                          onTapDown: (TapDownDetails tapDownDetails) async {
                            await showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(tapDownDetails.globalPosition.dx,tapDownDetails.globalPosition.dy,0,0),
                            items: [
                              PopupMenuItem<int>(
                                  value: 0,
                                  onTap: (){
                                    productAttributeValueController.value = TextEditingValue(text: e.value.attributeValueName);
                                    Future.delayed(
                                        Duration.zero, () => attributeValueBottomSheet(
                                        formKey: attributeValueFormKey,
                                        controller: productAttributeValueController,
                                        focusNode: productAttributeValueFocusNode,
                                        onPress: (){
                                          if (attributeValueFormKey.currentState?.validate() ?? false) {
                                            attributeValueFormKey.currentState?.save();

                                            setState(() {
                                              attributeValues[e.key] = AttributeValue(
                                                  attributeValueName: productAttributeValueController.text.toString(),
                                                  attributeValueSelected: e.value.attributeValueSelected
                                              );
                                            });

                                            return true;
                                          }

                                          return false;
                                        }
                                    )
                                    );
                                  },
                                  child: menuWidget(iconData: Icons.edit, title: "Edit")
                              ),
                              PopupMenuItem<int>(
                                value: 1,
                                onTap: (){
                                  Future.delayed(
                                      Duration.zero,
                                          () => deleteDialog(
                                              context: context,
                                              deleteFunction: (){
                                                attributeValues.removeAt(e.key);

                                                if(mounted){
                                                  setState(() {});
                                                }
                                              }
                                          )
                                  );
                                },
                                child: menuWidget(iconData: Icons.delete_outline, title: "Delete")
                              )
                            ]
                            );
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                            decoration: const ShapeDecoration(
                              shape: StadiumBorder(
                                  side: BorderSide.none
                              ),
                              color: ColorRes.primaryColor
                            ),
                            child:  Text(
                              e.value.attributeValueName,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorRes.whiteColor),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Product Category",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        )
                      ],
                    ),
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
                    child: DropdownButton<TopMenuModel>(
                      alignment: Alignment.center,
                      hint:  SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Select product category",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorRes.primaryLightColor
                          ),
                        ),
                      ),
                      focusColor: ColorRes.whiteColor,
                      value: selectedCategory,
                      isExpanded: true,
                      isDense: true,
                      dropdownColor: ColorRes.whiteColor,
                      style: Theme.of(context).textTheme.bodyMedium,
                      icon: const Icon(Icons.keyboard_arrow_down, size: 24, color: ColorRes.primaryColor),
                      underline: Container(),
                      onChanged: (TopMenuModel? value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      items: widget.categories.map((TopMenuModel position) {
                        return  DropdownMenuItem<TopMenuModel>(
                          value: position,
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              position.title,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "Product Images",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: PopupMenuButton(
                              color: ColorRes.whiteColor,
                              icon: const Icon(Icons.add),
                              iconSize: 24,
                              splashRadius: 24,
                              tooltip: "Add image using Camera/Gallery",
                              itemBuilder: (context){
                                return [
                                  PopupMenuItem<int>(
                                      value: 0,
                                      child: menuWidget(iconData: Icons.camera, title: "Camera")
                                  ),
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: menuWidget(iconData: Icons.image_rounded, title: "Gallery")
                                  )
                                ];
                              },
                              onSelected:(value) async {
                                if(value == 0){
                                  getImageFromCamera(edit: false, index: -1);
                                }
                                else if(value == 1){
                                  getImageFromGallery(edit: false, index: -1);
                                }
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                  if(imagePaths.isNotEmpty)
                  Container(
                    height: 102,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext builderContext, int builderIndex){
                          String imagePath = imagePaths[builderIndex];
                          return GestureDetector(
                            onTapDown: (TapDownDetails tapDownDetails) async {
                              await showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(tapDownDetails.globalPosition.dx,tapDownDetails.globalPosition.dy,0,0),
                                  items: [
                                    PopupMenuItem<int>(
                                        value: 0,
                                        onTap: (){
                                          Future.delayed(
                                              Duration.zero,
                                                  () => showMenu(
                                                      context: context,
                                                      position: RelativeRect.fromLTRB(tapDownDetails.globalPosition.dx,tapDownDetails.globalPosition.dy,0,0),
                                                      items: [
                                                        PopupMenuItem<int>(
                                                            value: 0,
                                                            onTap: (){
                                                              getImageFromCamera(edit: true, index: builderIndex);
                                                            },
                                                            child: menuWidget(iconData: Icons.camera, title: "Camera")
                                                        ),
                                                        PopupMenuItem<int>(
                                                          value: 1,
                                                          onTap: (){
                                                            getImageFromGallery(edit: true, index: builderIndex);
                                                          },
                                                          child: menuWidget(iconData: Icons.image_rounded, title: "Gallery")
                                                        )
                                                      ]
                                                  )
                                          );
                                        },
                                        child: menuWidget(iconData: Icons.edit, title: "Edit")
                                    ),
                                    PopupMenuItem<int>(
                                      value: 1,
                                      onTap: (){
                                        Future.delayed(
                                            Duration.zero,
                                                () => deleteDialog(
                                                    context: context,
                                                    deleteFunction: (){
                                                      imagePaths.removeAt(builderIndex);

                                                      if(mounted){
                                                        setState(() {});
                                                      }
                                                    }
                                                )
                                        );
                                      },
                                      child: menuWidget(iconData: Icons.delete_outline, title: "Delete")
                                    )
                                  ]
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: ColorRes.smokeWhiteColor
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                child: myMemoryImage(
                                    imagePath: base64Decode(imagePath),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext separatorContext, int separatorIndex){
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        itemCount: imagePaths.length
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: TextButton(
                        onPressed: (){
                          if (productFormKey.currentState?.validate() ?? false) {
                            productFormKey.currentState?.save();

                            if(selectedCategory == null){
                              alertDialog(context: context, alertMessage: "Please select product category.");
                            }
                            else if(imagePaths.isEmpty){
                              alertDialog(context: context, alertMessage: "Please select at least one product image.");
                            }
                            else{
                              if(widget.editProductModel == null){
                                saveNewProduct(
                                  productModel: ProductModel(
                                      id: 0,
                                      name: productNameController.text.toString(),
                                      imageUrl: imagePaths,
                                      details: productDetailController.text.toString(),
                                      price: int.parse(productPriceController.text.toString()),
                                      item: 1,
                                      rating: 0.0,
                                      quantity: 0,
                                      categoryId: selectedCategory!.id,
                                      attributes: Attributes(
                                          attributeName: productAttributeTitleController.text.toString(),
                                          attributeValues: attributeValues
                                      )
                                  )
                                );
                              }
                              else{
                                editProduct(
                                    productModel: ProductModel(
                                        id: widget.editProductModel!.id,
                                        name: productNameController.text.toString(),
                                        imageUrl: imagePaths,
                                        details: productDetailController.text.toString(),
                                        price: int.parse(productPriceController.text.toString()),
                                        item: widget.editProductModel!.item,
                                        rating: widget.editProductModel!.rating,
                                        quantity: widget.editProductModel!.quantity,
                                        categoryId: selectedCategory!.id,
                                        attributes: Attributes(
                                            attributeName: productAttributeTitleController.text.toString(),
                                            attributeValues: attributeValues
                                        )
                                    )
                                );
                              }

                              widget.refreshProductsScreen.call();
                              Navigator.pop(context);
                            }
                          }
                        },
                        style: Theme.of(context).textButtonTheme.style,
                        child: const Text(StringRes.saveTitle)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget menuWidget({
    required IconData iconData,
    required String title
  }){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 16,
          color: ColorRes.primaryColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget titleTextWidget({
    required String title,
    double? topMargin
  }){
    return Container(
      margin: EdgeInsets.only(top: topMargin ?? 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          )
        ],
      ),
    );
  }

  Widget productsName({
    required BuildContext context
  }){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: MyInputField(
        controller: productNameController,
        focusNode: productNameFocusNode,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: myInputDecoration(
            context: context,
            label: "",
            hint: "Enter product name",
            dense: true
        ),
        validator: (String? value){
          return textValidator(
              value: value,
              errorMessage: "Please enter product name"
          );
        },
      ),
    );
  }

  Widget productsDetail({
    required BuildContext context
  }){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: MyInputField(
        controller: productDetailController,
        focusNode: productDetailFocusNode,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: myInputDecoration(
            context: context,
            label: "",
            hint: "Enter product detail",
            dense: true
        ),
        validator: (String? value){
          return textValidator(
              value: value,
              errorMessage: "Please enter product detail"
          );
        },
      ),
    );
  }

  Widget productsPrice({
    required BuildContext context
  }){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: MyInputField(
        controller: productPriceController,
        focusNode: productPriceFocusNode,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: myInputDecoration(
            context: context,
            label: "",
            hint: "Enter product price",
            dense: true
        ),
        validator: (String? value){
          return doubleValueValidator(
              value: value,
              emptyMessage: "Please enter product price",
              invalidMessage: "Please enter valid product price"
          );
        },
      ),
    );
  }

  Widget productsAttributeTitle({
    required BuildContext context
  }){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: MyInputField(
        controller: productAttributeTitleController,
        focusNode: productAttributeTitleFocusNode,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: myInputDecoration(
            context: context,
            label: "",
            hint: "Enter product attribute title",
            dense: true
        ),
        validator: (String? value){
          return textValidator(
              value: value,
              errorMessage: "Please enter product attribute title"
          );
        },
      ),
    );
  }
}