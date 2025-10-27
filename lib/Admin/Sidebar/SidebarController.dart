import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:super_adminPanel/Admin/CityScreen/CityScreen.dart';
import 'package:super_adminPanel/Admin/CountryScreen/CountryScreen.dart';
import 'package:super_adminPanel/Admin/Employee/EmployeeScreen.dart';
import 'package:super_adminPanel/Admin/Keyword/KeywordScreen.dart';
import 'package:super_adminPanel/Admin/StateScreen/StateScreen.dart';

class Sidebarcontroller extends GetxController {
  var selectedIndex = 0.obs;
  var isCollapsed = false.obs;
  var isProfileSelected = false.obs;
  var showSearch = false.obs;
  var isSearchActive = false.obs;
  var dataFilterExpanded = false.obs;
  var isHovered = false;
  var selectedPath = ''.obs;

  final List<Widget> screens = [
    EmployeeScreen(),
    KeywordScreen(),
    CountryScreen(),
    StateScreen(),
    CityScreen(),
  ];

  // All route paths
  final List<String> allRoutes = [
    '/employee',
    '/keyword',
    '/country',
    '/state',
    '/city',
  ];


  void toggleCollapse() {
    isCollapsed.value = !isCollapsed.value;


    if (isCollapsed.value) {
      dataFilterExpanded.value = false;
    }
  }


  void toggleDataFilter() {
    dataFilterExpanded.value = !dataFilterExpanded.value;


    if (dataFilterExpanded.value) {
      selectedPath.value = '/data-filter';
    } else {

      selectedPath.refresh();
    }
  }


  void changeScreen(int index) {
    isProfileSelected.value = false;
    selectedIndex.value = index;
  }


  void setScreenByRoute(String route) {
    selectedPath.value = route;
    final r = route.toLowerCase();

    if (r.contains('employee')) {
      selectedIndex.value = 0;


      dataFilterExpanded.value = false;
    } else if (r.contains('keyword')) {
      selectedIndex.value = 1;
    } else if (r.contains('country')) {
      selectedIndex.value = 2;
    } else if (r.contains('state')) {
      selectedIndex.value = 3;
    } else if (r.contains('city')) {
      selectedIndex.value = 4;
    } else {
      selectedIndex.value = 0;
    }

    isProfileSelected.value = false;
  }


  String get currentScreenName {
    if (selectedIndex.value == -1) return 'Profile';
    switch (selectedIndex.value) {
      case 0:
        return 'employee';
      case 1:
        return 'keyword';
      case 2:
        return 'country';
      case 3:
        return 'state';
      case 4:
        return 'city';
      default:
        return 'employee';
    }
  }


  bool isSelected(String path) => selectedPath.value == path;


  bool isParentSelected(String label) {
    if (label.toLowerCase() == 'data filter') {
      return selectedPath.value == '/data-filter' ||
          selectedPath.value.contains('/keyword') ||
          selectedPath.value.contains('/country') ||
          selectedPath.value.contains('/state') ||
          selectedPath.value.contains('/city');
    }
    if (label.toLowerCase() == 'employees') {
      return selectedPath.value.contains('/employee');
    }
    return false;
  }
}
