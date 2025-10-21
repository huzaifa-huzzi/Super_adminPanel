import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeywordController extends GetxController {

  /// KeywordScreen
  RxList<Map<String, String>> keywordCategories = <Map<String, String>>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 5.obs;

  KeywordController() {
    keywordCategories.assignAll([
      {'Sn': '01', 'category': 'Digital Marketing'},
      {'Sn': '02', 'category': 'General Partnership'},
      {'Sn': '03', 'category': 'C Corporation'},
      {'Sn': '04', 'category': 'Car Washes'},
      {'Sn': '05', 'category': 'Real Estate'},
      {'Sn': '06', 'category': 'Event Management'},
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


  /// Add KeywordScreen
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
