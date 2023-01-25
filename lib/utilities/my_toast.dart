import 'package:fluttertoast/fluttertoast.dart';
import '../resources/color_res.dart';

Future<bool?> myToast(String text) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorRes.greenColor,
      textColor: ColorRes.whiteColor,
      fontSize: 14.0
  );
}