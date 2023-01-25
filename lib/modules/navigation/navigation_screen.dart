import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import '../../helper_methods/helper_methods.dart';
import '../../resources/color_res.dart';
import '../../resources/string_res.dart';
import '../../utilities/my_toast.dart';
import 'bottom_nav_list.dart';

class NavigationScreen extends StatefulWidget {
  final int index;
  const NavigationScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late int selectedIndex = widget.index;
  DateTime? currentBackPressTime;

  void tabChange(int currentIndex){
    setState((){
      selectedIndex = currentIndex;
    });
  }

  Future<bool> onWillPop() {
    if(selectedIndex != 0){
      tabChange(0);
      return Future.value(false);
    }
    else{
      DateTime now = DateTime.now();
      if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        myToast(StringRes.backButtonMessage);
        return Future.value(false);
      }
    }

    return Future.value(true);
  }

  Widget bottomBarIconWidget({
    required IconData iconData,
    required bool selected
  }){
    return Container(
      padding: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorRes.primaryLightColor
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 24,
            color: ColorRes.whiteColor,
          ),
          if(selected)
          Container(
            width: 3,
            height: 3,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          body: getBottomNavigationList(
            refreshFunction: (){setState(() {});},
            goToOrdersScreen: (){tabChange(1);}
          ).elementAt(selectedIndex),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    ColorRes.whiteColor,
                    ColorRes.whiteColor.withOpacity(0.2),
                  ],
                )
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  color: ColorRes.primaryColor
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        tabChange(0);
                      },
                      child: bottomBarIconWidget(
                          iconData: Icons.home_outlined,
                          selected: selectedIndex == 0
                      ),
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        tabChange(1);
                      },
                      child: badges.Badge(
                        showBadge: getOrderCount() != 0,
                        position: badges.BadgePosition.topEnd(
                            top: -8,
                            end: -6
                        ),
                        badgeContent: Center(
                          child: Text(
                            getOrderCount().toString(),
                            style: const TextStyle(
                                fontSize: 10,
                                color: ColorRes.whiteColor,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                        child: bottomBarIconWidget(
                            iconData: Icons.shopping_bag_outlined,
                            selected: selectedIndex == 1
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        tabChange(2);
                      },
                      child: badges.Badge(
                        showBadge: getProductCount() != 0,
                        position: badges.BadgePosition.topEnd(
                            top: -8,
                            end: -6
                        ),
                        badgeContent: Center(
                          child: Text(
                            getProductCount().toString(),
                            style: const TextStyle(
                                fontSize: 10,
                                color: ColorRes.whiteColor,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                        child: bottomBarIconWidget(
                            iconData: Icons.view_list_outlined,
                            selected: selectedIndex == 2
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        tabChange(3);
                      },
                      child: bottomBarIconWidget(
                          iconData: Icons.admin_panel_settings_outlined,
                          selected: selectedIndex == 3
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}