import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateController extends GetxController {

  RxList<Map<String, String>> keywordCategories = <Map<String, String>>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 5.obs;

  StateController() {
    keywordCategories.assignAll([
      {'Sn': '01', 'category': 'Australia','states' : 'Lombardy'},
      {'Sn': '02', 'category': 'Pakistan','states' : 'Aosta Valley'},
      {'Sn': '03', 'category': 'Bangladesh','states' : 'Veneto'},
      {'Sn': '04', 'category': 'South Korea','states' : 'Emilia-Romagna'},
      {'Sn': '05', 'category': 'Canada','states' : 'Liguaria'},
      {'Sn': '06', 'category': 'United States','states' : 'Le Marche'},
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


  /// Add state names
  final stateController = TextEditingController();
  final stateNode = FocusNode();
  final countryController = TextEditingController();
  final countryNode = FocusNode();

  var loading = false.obs;

  @override
  void onClose() {
    stateController.dispose();
    stateNode.dispose();
    countryController.dispose();
    countryNode.dispose();
    super.onClose();
  }



}
