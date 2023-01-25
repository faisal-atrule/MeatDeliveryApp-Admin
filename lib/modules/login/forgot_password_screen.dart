import 'package:flutter/material.dart';

import '../../helper_methods/helper_methods.dart';
import '../../resources/color_res.dart';
import '../../resources/string_res.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_input_decoration.dart';
import '../../widgets/my_input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          title: StringRes.forgotPasswordTitle,
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
              padding: const EdgeInsets.all(16),
              child: Form(
                key: forgotPasswordFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            StringRes.forgotPasswordDetail,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      ],
                    ),
                    email(context: context),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextButton(
                          onPressed: (){
                            if (forgotPasswordFormKey.currentState?.validate() ?? false) {
                              forgotPasswordFormKey.currentState?.save();
                            }
                          },
                          style: Theme.of(context).textButtonTheme.style,
                          child: const Text(StringRes.send)
                      ),
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

  Widget email({
    required BuildContext context
  }){
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: MyInputField(
          controller: emailController,
          focusNode: emailFocusNode,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: myInputDecoration(
              context: context,
              label: "Email",
              hint: "Enter registered email",
              dense: true
          ),
        validator: (String? value){
          return emailValidator(
              value: value,
              invalidMessage: "Please enter valid email",
              emptyMessage: "Please enter email"
          );
        },
      ),
    );
  }
}