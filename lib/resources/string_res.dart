import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/top_menu_model.dart';

class StringRes{
  static const String appName = "Meat App Admin";
  static const String backButtonMessage = "Press back button again to exit!";

  static const String loginTitle = "Login";
  static const String logoutTitle = "Logout";
  static const String forgotPasswordTitle = "Forgot password?";
  static const String forgotPasswordDetail = "Enter the email address associated with your account, we will send a password reset email to your registered account.";
  static const String send = "Send";

  static const String settingTitle = "General Settings";
  static const String appVersionTitle = "App Version";

  static const String catalogManagementTitle = "Catalog Management";
  static const String orderManagementTitle = "Order Management";
  static const String categoryTitle = "Product Categories";
  static const String productTitle = "Products";

  static const String addCategoryTitle = "Add Category";
  static const String editCategoryTitle = "Edit Category";
  static const String saveTitle = "Save";
  static const String addProductTitle = "Add Product";
  static const String editProductTitle = "Edit Product";

  static List<ProductModel> products = [];

  static List<TopMenuModel> productCategories = [];

  static List<OrderModel> orders = [];

  static List<String> orderStatuses = ["Pending", "Processing", "Complete", "Cancelled"];
}