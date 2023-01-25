import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../../helper_methods/helper_methods.dart';
import '../../../../models/top_menu_model.dart';
import '../../../../resources/color_res.dart';
import '../../../../resources/string_res.dart';
import '../../../../widgets/my_app_bar.dart';
import '../../../../widgets/my_image_widgets.dart';
import '../../../../widgets/my_input_decoration.dart';
import '../../../../widgets/my_input_field.dart';

class AddProductCategoryScreen extends StatefulWidget {
  final TopMenuModel? editMenuModel;
  final Function refreshCategoriesScreen;
  const AddProductCategoryScreen({super.key, required this.editMenuModel, required this.refreshCategoriesScreen});

  @override
  State<AddProductCategoryScreen> createState() => _AddProductCategoryScreenState();
}

class _AddProductCategoryScreenState extends State<AddProductCategoryScreen> {
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();

  TextEditingController categoryNameController = TextEditingController();
  FocusNode categoryNameFocusNode = FocusNode();

  String imagePath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.editMenuModel != null){
      setState(() {
        categoryNameController.value = TextEditingValue(text: widget.editMenuModel!.title);
        imagePath = widget.editMenuModel!.iconPath;
      });
    }
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    categoryNameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          title: widget.editMenuModel == null ? StringRes.addCategoryTitle : StringRes.editCategoryTitle,
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
              key: categoryFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Category Name",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      )
                    ],
                  ),
                  categoryName(context: context),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Category Image",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: ColorRes.smokeWhiteColor
                            ),
                            child: imagePath != "" ?
                            myMemoryImage(
                                imagePath: base64Decode(imagePath),
                                width: 50,
                                height: 50
                            ) :
                            const SizedBox(
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.red,
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
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.camera,
                                          size: 16,
                                          color: ColorRes.primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "Camera",
                                            style: Theme.of(context).textTheme.bodyLarge,
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.image_rounded,
                                          size: 16,
                                          color: ColorRes.primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "Gallery",
                                            style: Theme.of(context).textTheme.bodyLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ];
                              },
                              onSelected:(value) async {
                                if(value == 0){
                                  String returnPath = await checkCameraPermission(context);
                                  if(imagePath == ""){
                                    imagePath = returnPath;
                                  }
                                  else{
                                    if(returnPath != ""){
                                      imagePath = returnPath;
                                    }
                                  }

                                  if(mounted){
                                    setState(() {});
                                  }
                                }
                                else if(value == 1){
                                  String returnPath = await checkStoragePermissionForGallery(context);
                                  if(imagePath == ""){
                                    imagePath = returnPath;
                                  }
                                  else{
                                    if(returnPath != ""){
                                      imagePath = returnPath;
                                    }
                                  }
                                  if(mounted){
                                    setState(() {});
                                  }
                                }
                              }
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: TextButton(
                        onPressed: (){
                          if (categoryFormKey.currentState?.validate() ?? false) {
                            categoryFormKey.currentState?.save();

                            if(imagePath == ""){
                              alertDialog(context: context, alertMessage: "Please select an image for category.");
                            }
                            else{
                              if(widget.editMenuModel == null){
                                saveNewProductCategory(
                                    topMenuModel: TopMenuModel(id: 0, iconPath: imagePath, title: categoryNameController.text.toString())
                                );
                              }
                              else{
                                editProductCategory(
                                    topMenuModel: TopMenuModel(id: widget.editMenuModel!.id, iconPath: imagePath, title: categoryNameController.text.toString())
                                );
                              }

                              widget.refreshCategoriesScreen.call();
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

  Widget categoryName({
    required BuildContext context
  }){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: MyInputField(
        controller: categoryNameController,
        focusNode: categoryNameFocusNode,
        maxLength: 32,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: myInputDecoration(
            context: context,
            label: "",
            hint: "Enter category name",
            dense: true,
            hasMaxLength: true
        ),
        validator: (String? value){
          return textValidator(
              value: value,
              errorMessage: "Please enter category name"
          );
        },
      ),
    );
  }
}