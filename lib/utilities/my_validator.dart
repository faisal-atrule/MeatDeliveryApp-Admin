class MyValidator{
  //region Singleton implementation
  MyValidator._internal();
  static final MyValidator _myValidator = MyValidator._internal();
  factory MyValidator() => _myValidator;
  static MyValidator get instance => _myValidator;
  //endregion

  bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  bool isEmail(String s) => hasMatch(s, r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  bool isPhoneNumber(String s) {
    if (s.length > 11 || s.length < 11) return false;
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }
}