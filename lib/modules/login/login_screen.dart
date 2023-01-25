import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../data/local/my_local_storage.dart';
import '../../helper_methods/helper_methods.dart';
import '../../resources/asset_res.dart';
import '../../resources/color_res.dart';
import '../../resources/string_res.dart';
import '../../widgets/my_input_decoration.dart';
import '../../widgets/my_input_field.dart';
import '../navigation/navigation_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  login() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      loginFormKey.currentState?.save();

      await MyLocalStorage.instance.setBool(MyLocalStorage.isAdminLogin, true);

      if(mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavigationScreen(index: 0,),));
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();

    passwordController.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 1/0.7,
                  child: Lottie.asset(
                      AssetRes.splashLogoLottieFile,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      email(context: context),
                      password(context: context),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                                },
                                child: Text(
                                  StringRes.forgotPasswordTitle,
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorRes.crimsonColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextButton(
                            onPressed: (){
                              login();
                            },
                            style: Theme.of(context).textButtonTheme.style,
                            child: const Text(StringRes.loginTitle)
                        ),
                      )
                    ],
                  ),
                )
              ],
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
              hint: "Enter email",
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

  Widget password({
    required BuildContext context
  }){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: MyInputField(
          controller: passwordController,
          focusNode: passwordFocusNode,
          obscureText: true,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: myInputDecoration(
              context: context,
              label: "Password",
              hint: "Enter password",
              dense: true
          ),
        validator: (String? value){
          return passwordValidator(
              value: value,
              invalidMessage: "Password must contain 6 characters",
              emptyMessage: "Please enter password"
          );
        },
        onFieldSubmitted: (value){
          passwordFocusNode.unfocus();
          login();
        },
      ),
    );
  }
}