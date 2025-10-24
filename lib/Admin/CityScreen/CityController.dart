import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_adminPanel/Resources/Colors.dart';

class CityController extends GetxController {
  RxList<Map<String, String>> keywordCategories = <Map<String, String>>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 5.obs;

  CityController() {
    keywordCategories.assignAll([
      {'Sn': '01', 'category': 'Australia', 'states': 'Lombardy', 'city': 'L’Aquila'},
      {'Sn': '02', 'category': 'Pakistan', 'states': 'Aosta Valley', 'city': 'Potenza'},
      {'Sn': '03', 'category': 'Bangladesh', 'states': 'Veneto', 'city': 'Catanzaro'},
      {'Sn': '04', 'category': 'South Korea', 'states': 'Emilia-Romagna', 'city': 'Naples'},
      {'Sn': '05', 'category': 'Canada', 'states': 'Liguaria', 'city': 'Bologna'},
      {'Sn': '06', 'category': 'United States', 'states': 'Le Marche', 'city': 'Triesta'},
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

  /// Add city names
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


double scaleForWidth(BuildContext context, double size) {
  final width = MediaQuery.of(context).size.width;
  if (width >= 1600) return size;
  if (width >= 1200) return size * 0.9;
  if (width >= 800) return size * 0.8;
  if (width >= 600) return size * 0.75;
  return size * 0.7;
}

void showDeleteConfirmationDialog(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final bool isMobile = screenWidth < 600;

  double pad(double value) => scaleForWidth(context, value);
  double font(double size) => scaleForWidth(context, size);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? 280 : 340,
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(pad(12)),
            child: Padding(
              padding: EdgeInsets.all(pad(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Are You Sure?",
                    style: TextStyle(
                      fontSize: font(20),
                      fontWeight: FontWeight.bold,
                      color: AppColors.redColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: pad(25)),

                  /// Buttons
                  Flex(
                    direction: isMobile ? Axis.vertical : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Cancel Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(pad(8)),
                            side: const BorderSide(color: Colors.black12),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: pad(12),
                            horizontal: pad(30),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: font(14),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: isMobile ? 0 : pad(20),
                        height: isMobile ? pad(12) : 0,
                      ),

                      /// Delete Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.backgroundOfLogoutColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(pad(8)),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: pad(12),
                            horizontal: pad(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: font(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
