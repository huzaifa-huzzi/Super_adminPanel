import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryController extends GetxController {

  /// country Screen
  RxList<Map<String, String>> keywordCategories = <Map<String, String>>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 5.obs;

  CountryController() {
    keywordCategories.assignAll([
      {'Sn': '01', 'category': 'Australia'},
      {'Sn': '02', 'category': 'Pakistan'},
      {'Sn': '03', 'category': 'Bangladesh'},
      {'Sn': '04', 'category': 'South Korea'},
      {'Sn': '05', 'category': 'Canada'},
      {'Sn': '06', 'category': 'United States'},
    ]);
  }

  void deleteKeyword(int index) {
    keywordCategories.removeAt(index);
  }

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      update();
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      update();
    }
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      update();
    }
  }


  /// Add country names
  final keywordCategoryNameController = TextEditingController();
  final keywordCategoryNameNode = FocusNode();
  var loading = false.obs;

  @override
  void onClose() {
    keywordCategoryNameController.dispose();
    keywordCategoryNameNode.dispose();
    super.onClose();
  }



}
