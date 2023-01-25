import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'data/local/my_local_storage.dart';
import 'helper_methods/helper_methods.dart';
import 'modules/splash/splash_screen.dart';
import 'resources/string_res.dart';
import 'resources/theme_res.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  convertStatusBarToWhite();
  await MyLocalStorage.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: StringRes.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeRes.lightTheme,
        darkTheme: ThemeRes.lightTheme,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}