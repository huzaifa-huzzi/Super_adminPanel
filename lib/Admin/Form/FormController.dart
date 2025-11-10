import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FormController extends GetxController {
  RxList<Map<String, String>> forms = <Map<String, String>>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 5.obs;
  RxString selectedStatus = "All Status".obs;
  TextEditingController searchController = TextEditingController();
  RxString selectedCategory = "All Keyword Category".obs;



  final List<String> keywordCategories = [
    "All Keyword Category",
    "Keyword Title",
    "Number Type",
    "Phone Number",
    "Email",
    "Website",
    "Country",
    "State",
    "City",
    "Suburb",
    "Zip Code",
    "Address",
    "Lazina",
  ];



  FormController() {
    forms.assignAll([
      {
        'Sn': '01',
        'Keyword Category': 'Digital Marketing',
        'Keyword Title': 'Demo Title',
        'Name': 'Lazina Pramarik',
        'Number Type': 'Business',
        'Number': '+880-1111222',
        'Email': 'demoemail@gmail.com',
        'Website': 'https://demoexample.com',
        'Country': 'Australia',
        'State': 'New South Wales',
        'City': 'Lidcombe',
        'Suburb': 'Lidcombe',
        'Zip Code': '2141',
        'Address': '102 Queen Street, NSW',
        'Submitted By': 'L. Admin',
      },
      {
        'Sn': '02',
        'Keyword Category': 'General Partnership',
        'Keyword Title': 'Demo Title',
        'Name': 'Lazina Pramarik',
        'Number Type': 'Personal',
        'Number': '+880-1111223',
        'Email': 'demoemail@gmail.com',
        'Website': 'https://demoexample.com',
        'Country': 'Pakistan',
        'State': 'Punjab',
        'City': 'Okara',
        'Suburb': 'Faisal Colony',
        'Zip Code': '53400',
        'Address': '102 Greenfield Street',
        'Submitted By': 'L. Admin',
      },
      {
        'Sn': '03',
        'Keyword Category': 'C Corporations',
        'Keyword Title': 'Demo Title',
        'Name': 'Lazina Pramarik',
        'Number Type': 'Business',
        'Number': '+880-1111224',
        'Email': 'demoemail@gmail.com',
        'Website': 'https://demoexample.com',
        'Country': 'Bangladesh',
        'State': 'New South Wales',
        'City': 'Dhaka',
        'Suburb': 'Mirpur',
        'Zip Code': '1206',
        'Address': '56 Central Road',
        'Submitted By': 'L. Admin',
      },
      {
        'Sn': '04',
        'Keyword Category': 'Car Washes',
        'Keyword Title': 'Demo Title',
        'Name': 'Lazina Pramarik',
        'Number Type': 'Business',
        'Number': '+880-1111225',
        'Email': 'demoemail@gmail.com',
        'Website': 'https://demoexample.com',
        'Country': 'South Korea',
        'State': 'Seoul',
        'City': 'Mapo-gu',
        'Suburb': 'Sangsu-dong',
        'Zip Code': '04074',
        'Address': '89 Street Line, Seoul',
        'Submitted By': 'L. Admin',
      },
      {
        'Sn': '05',
        'Keyword Category': 'Real Estate',
        'Keyword Title': 'Demo Title',
        'Name': 'Lazina Pramarik',
        'Number Type': 'Business',
        'Number': '+880-1111226',
        'Email': 'demoemail@gmail.com',
        'Website': 'https://demoexample.com',
        'Country': 'Canada',
        'State': 'Ontario',
        'City': 'Burlington',
        'Suburb': 'Burlington',
        'Zip Code': '2141',
        'Address': '102 Queen Street, Ontario',
        'Submitted By': 'L. Admin',
      },
      {
        'Sn': '06',
        'Keyword Category': 'Event Management',
        'Keyword Title': 'Demo Title',
        'Name': 'Lazina Pramarik',
        'Number Type': 'Personal',
        'Number': '+880-1111227',
        'Email': 'demoemail@gmail.com',
        'Website': 'https://demoexample.com',
        'Country': 'United States',
        'State': 'New York',
        'City': 'Fresno',
        'Suburb': 'Fresno',
        'Zip Code': '53400',
        'Address': '102 Greenfield Street',
        'Submitted By': 'L. Admin',
      },
    ]);

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



}
