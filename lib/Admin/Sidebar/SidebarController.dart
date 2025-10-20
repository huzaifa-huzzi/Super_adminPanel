import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lead_adminpanelone/Admin/Employee/EmployeeScreen.dart';
import 'package:lead_adminpanelone/Admin/CityScreen/CityScreen.dart';
import 'package:lead_adminpanelone/Admin/CountryScreen/CountryScreen.dart';
import 'package:lead_adminpanelone/Admin/Keyword/KeywordScreen.dart';
import 'package:lead_adminpanelone/Admin/StateScreen/StateScreen.dart';


class Sidebarcontroller extends GetxController {
  var selectedIndex = 0.obs;
  var isCollapsed = false.obs;
  var isProfileSelected = false.obs;
  var showSearch = false.obs;
  var isHovered = false;
  var isSearchActive = false.obs;

  final List<Widget> screens = [
    EmployeeScreen(),
    KeywordScreen(),
    CountryScreen(),
    StateScreen(),
    CityScreen(),
  ];

  void toggleCollapse() => isCollapsed.value = !isCollapsed.value;
  void changeScreen(int index) {
    isProfileSelected.value = false;
    selectedIndex.value = index;
  }

  void setScreenByRoute(String route) {
    final r = route.toLowerCase();
      /// This code is placed for the Profile (In case if the requirements changes)
   // if (r.contains('profile')) {
     // selectedIndex.value = -1;
    //  isProfileSelected.value = true;
    //  return;
   // }
    if (r.contains('employee')) {
      selectedIndex.value = 0;
    } else if (r.contains('keyword')) {
      selectedIndex.value = 1;
    } else if (r.contains('country')) {
      selectedIndex.value = 2;
    } else if (r.contains('state')) {
      selectedIndex.value = 3;
    }else if (r.contains('city')) {
      selectedIndex.value = 4;
    }

    else {
      selectedIndex.value = 0;
    }
    isProfileSelected.value = false;
  }


  String get currentScreenName {
    if (selectedIndex.value == -1) return 'Profile';
    switch (selectedIndex.value) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Form Submit';
      case 2:
        return 'Verify';
      default:
        return 'Dashboard';
    }
  }
}