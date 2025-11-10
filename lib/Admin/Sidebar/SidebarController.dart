import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:super_adminPanel/Admin/CityScreen/CityScreen.dart';
import 'package:super_adminPanel/Admin/CountryScreen/CountryScreen.dart';
import 'package:super_adminPanel/Admin/Dashboard/DashboardScreen.dart';
import 'package:super_adminPanel/Admin/Employee/EmployeeScreen.dart';
import 'package:super_adminPanel/Admin/Form/FormScreen.dart';
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
    DashboardScreen(),
    EmployeeScreen(),
    FormScreen(),
    KeywordScreen(),
    CountryScreen(),
    StateScreen(),
    CityScreen(),

  ];

  // All route paths
  final List<String> allRoutes = [
    '/dashboard',
    '/employee',
    '/keyword',
    '/country',
    '/state',
    '/city',
    '/form'

  ];



  void toggleCollapse() {
    isCollapsed.value = !isCollapsed.value;
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


    if (r.contains('employee') || r.contains('form') || r.contains('dashboard')) {
      dataFilterExpanded.value = false;
    }


    if (r.contains('dashboard')) {
      selectedIndex.value = 0;
    } else if (r.contains('employee')) {
      selectedIndex.value = 1;
    } else if (r.contains('keyword')) {
      selectedIndex.value = 2;
    } else if (r.contains('country')) {
      selectedIndex.value = 3;
    } else if (r.contains('state')) {
      selectedIndex.value = 4;
    } else if (r.contains('city')) {
      selectedIndex.value = 5;
    } else if (r.contains('form')) {
      selectedIndex.value = 6;
    } else {
      selectedIndex.value = 0;
    }

    isProfileSelected.value = false;
  }



  String get currentScreenName {
    switch (selectedIndex.value) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Employee';
      case 2:
        return 'Keyword';
      case 3:
        return 'Country';
      case 4:
        return 'State';
      case 5:
        return 'City';
      case 6:
        return 'Form';
      default:
        return 'Dashboard';
    }
  }



  bool isSelected(String path) => selectedPath.value == path;

  bool isParentSelected(String label) {
    final path = selectedPath.value.toLowerCase();

    if (label.toLowerCase() == 'data filter') {
      return dataFilterExpanded.value ||
          path.contains('/keyword') ||
          path.contains('/country') ||
          path.contains('/state') ||
          path.contains('/city');
    }

    if (label.toLowerCase() == 'employees') {
      return path.contains('/employee');
    }

    if (label.toLowerCase() == 'forms') {
      return path.contains('/form');
    }

    if (label.toLowerCase() == 'dashboard') {
      return path.contains('/dashboard');
    }

    return false;
  }



}
