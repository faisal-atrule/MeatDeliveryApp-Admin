import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../data/local/my_local_storage.dart';
import '../../../helper_methods/helper_methods.dart';
import '../../../resources/asset_res.dart';
import '../../../resources/color_res.dart';
import '../../../resources/string_res.dart';
import '../../login/login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Widget accountOptions({
    required String title,
    required IconData iconData
  }){
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Icon(
              iconData,
              color: ColorRes.primaryColor,
              size: 24,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const Icon(
                          Icons.double_arrow_outlined,
                          color: ColorRes.primaryColor,
                          size: 24,
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: ColorRes.primaryColor,
                    height: 0.2,
                    thickness: 0.2,
                  )
                ],
              ),
            ),
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
                margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: ColorRes.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: AspectRatio(
                  aspectRatio: 1/0.7,
                  child: Lottie.asset(
                      AssetRes.splashLogoLottieFile,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        StringRes.settingTitle,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  PackageInfo.fromPlatform().then((PackageInfo value){
                    alertDialog(context: context, icon: Icons.verified, alertMessage: "${value.appName}, ${value.version} (${value.buildNumber})");
                  });
                },
                child: accountOptions(
                    title: StringRes.appVersionTitle,
                    iconData: Icons.numbers_outlined
                ),
              ),
              GestureDetector(
                onTap: (){
                  logoutDialog(
                      context: context,
                      logoutFunction: () async {
                        await MyLocalStorage.instance.setBool(MyLocalStorage.isAdminLogin, false);

                        if(mounted){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          const LoginScreen()), (Route<dynamic> route) => false);
                        }
                      }
                  );
                },
                child: accountOptions(
                    title: StringRes.logoutTitle,
                    iconData: Icons.logout_rounded
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}