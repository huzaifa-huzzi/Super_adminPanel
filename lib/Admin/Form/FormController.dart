import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:super_adminPanel/Resources/Colors.dart';

class FormController extends GetxController {
  RxList<Map<String, String>> forms = <Map<String, String>>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 5.obs;
  RxString selectedStatus = "All Status".obs;
  TextEditingController searchController = TextEditingController();
  RxString selectedCategory = "All Keyword Category".obs;
  final popupKey = GlobalKey();



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
    "Submitted By",
  ];


   /// download Now Code
  final downloadOptions = <String>[
    'All',
    'Digital marketing',
    'General Partnership',
    'C Corporation',
    'Car Washes',
    'Real Estate',
    'Event Management',
  ].obs;

  final selectedOptions = <String, bool>{
    'All': true,
    'Digital marketing': false,
    'General Partnership': false,
    'C Corporation': false,
    'Car Washes': false,
    'Real Estate':false,
    'Event Management':false,
  }.obs;

  void toggleOption(String key, bool value) {
    selectedOptions[key] = value;
    selectedOptions.refresh();
  }


  void showPopupMenu(BuildContext context) {
    final RenderBox button =
    popupKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
    Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      color: AppColors.dividerColor,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          button.localToGlobal(Offset.zero, ancestor: overlay),
          button.localToGlobal(button.size.bottomRight(Offset.zero),
              ancestor: overlay),
        ),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.zero,
          child: Obx(() {
            final options = downloadOptions;
            final selected = selectedOptions;

            return Container(
              width: 260,
              decoration: BoxDecoration(
                color: AppColors.dividerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < options.length; i++) ...[
                    CheckboxListTile(
                      dense: true,
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12),
                      title: Text(
                        options[i],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.TextformFieldsTextColor,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                      visualDensity: const VisualDensity(vertical: -4),
                      activeColor: AppColors.primaryColor,
                      value: selected[options[i]],
                      onChanged: (bool? value) {
                        toggleOption(options[i], value ?? false);
                      },
                    ),
                    if (i != options.length - 1)
                      const Divider(
                        height: 1,
                        thickness: 0.7,
                        color: Color(0xFFE0E0E0),
                      ),
                  ],
                ],
              ),
            );
          }),
        ),
      ],
    );
  }





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
