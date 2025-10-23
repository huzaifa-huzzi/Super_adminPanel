import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityController extends GetxController {

  RxList<Map<String, String>> keywordCategories = <Map<String, String>>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 5.obs;

  CityController() {
    keywordCategories.assignAll([
      {'Sn': '01', 'category': 'Australia','states' : 'Lombardy','city':'L’Aquila'},
      {'Sn': '02', 'category': 'Pakistan','states' : 'Aosta Valley','city':'Potenza'},
      {'Sn': '03', 'category': 'Bangladesh','states' : 'Veneto','city':'Catanzaro'},
      {'Sn': '04', 'category': 'South Korea','states' : 'Emilia-Romagna','city':'Naples'},
      {'Sn': '05', 'category': 'Canada','states' : 'Liguaria','city':'Bologna'},
      {'Sn': '06', 'category': 'United States','states' : 'Le Marche','city':'Triesta'},
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
  final cityController = TextEditingController();
  final cityNode = FocusNode();

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
