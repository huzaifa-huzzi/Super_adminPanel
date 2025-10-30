import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_adminPanel/Resources/Colors.dart';
import 'package:super_adminPanel/Resources/IconStrings.dart';
import 'package:super_adminPanel/Admin/Employee/EmployeeController.dart';

class EditEmployeeInfoScreen extends StatelessWidget {
  EditEmployeeInfoScreen({super.key});

  final controller = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1000;

    double scaleFor(double mobile, double tablet, double desktop) {
      if (isMobile) return mobile;
      if (isTablet) return tablet;
      return desktop;
    }

    return Align(
      alignment: isMobile ? Alignment.center : Alignment.topCenter,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? scaleFor(10, 20, 40) : scaleFor(20, 40, 60),
          vertical: scaleFor(20, 30, 40),
        ),
        child: Container(
          width: isMobile ? width * 0.95 : (isTablet ? width * 0.7 : width * 0.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(scaleFor(10, 12, 14)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: scaleFor(3, 4, 5),
                spreadRadius: 1,
              ),
            ],

          ),
          padding: EdgeInsets.all(scaleFor(14, 18, 20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---- Title ----///
              Text(
                "Edit Employee",
                style:Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: scaleFor(15, 17, 19),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: scaleFor(14, 18, 20)),

              /// ---- Short Name ----
              _buildRow(
                context,
                isMobile,
                isTablet,
                icon: IconsString.nameIcon,
                label: "Short Name",
                value: "LP",
                onTap: () {},
                scaleFor: scaleFor,
              ),
              Divider(color: AppColors.dividerColor),

              /// ---- Name ----
              _buildRow(
                context,
                isMobile,
                isTablet,
                icon: IconsString.nameIcon,
                label: "Name",
                value: "Mst. Lazina Khatun",
                onTap: () {},
                scaleFor: scaleFor,
              ),
              Divider(color: AppColors.dividerColor),

              /// ---- User Name ----
              _buildRow(
                context,
                isMobile,
                isTablet,
                icon: IconsString.nameIcon,
                label: "User Name",
                value: "Lazina Pramanik",
                onTap: () {},
                scaleFor: scaleFor,
              ),
              Divider(color: AppColors.dividerColor),

              /// ---- Password ----
              Obx(() {
                final isVisible = controller.visiblePasswords.contains(0);
                return _buildRow(
                  context,
                  isMobile,
                  isTablet,
                  icon: IconsString.passwordIcon,
                  label: "Password",
                  value: isVisible ? "12345" : "•••••",
                  onTap: () {
                    if (controller.visiblePasswords.contains(0)) {
                      controller.visiblePasswords.remove(0);
                    } else {
                      controller.visiblePasswords.add(0);
                    }
                  },
                  scaleFor: scaleFor,
                  isPassword: true,
                  isVisible: isVisible,
                );
              }),
              Divider(color: AppColors.dividerColor),

              /// ---- Status ----
              _buildRow(
                context,
                isMobile,
                isTablet,
                icon: IconsString.statusIcon,
                label: "Status",
                value: "Active",
                onTap: () {},
                scaleFor: scaleFor,
                isStatus: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ------------------- Row Builder -------------------
  Widget _buildRow(
      BuildContext context,
      bool isMobile,
      bool isTablet, {
        required String icon,
        required String label,
        required String value,
        required VoidCallback onTap,
        required double Function(double, double, double) scaleFor,
        bool isPassword = false,
        bool isVisible = false,
        bool isStatus = false,
      }) {
    final iconSize = scaleFor(16, 18, 20);
    final fontSize = scaleFor(13, 14, 15);
    final valueSize = scaleFor(13, 14, 15);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: scaleFor(6, 8, 10)),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(icon, height: iconSize, width: iconSize),
              SizedBox(width: scaleFor(8, 10, 12)),
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  color: AppColors.captionsColor,
                  decoration: TextDecoration.none,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onTap,
                child: Icon(
                  isPassword
                      ? (isVisible ? Icons.visibility : Icons.visibility_off)
                      : Icons.edit,
                  size: scaleFor(16, 17, 18),
                  color: AppColors.textColors.withOpacity(0.7),
                ),
              ),
            ],
          ),
          SizedBox(height: scaleFor(4, 6, 8)),
          isStatus
              ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: scaleFor(10, 12, 14),
              vertical: scaleFor(4, 5, 6),
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundActiveColor,
              borderRadius: BorderRadius.circular(scaleFor(6, 7, 8)),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.activeTextColor,
                fontSize: valueSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
              : Text(
            value,
            style: TextStyle(
              fontSize: valueSize,
              fontWeight: FontWeight.w600,
              color: AppColors.textColors,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      )
          : Row(
        children: [
          Image.asset(icon, height: iconSize, width: iconSize),
          SizedBox(width: scaleFor(8, 10, 12)),
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                color: AppColors.captionsColor,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: isStatus
                ? Container(
              padding: EdgeInsets.symmetric(
                horizontal: scaleFor(10, 12, 14),
                vertical: scaleFor(4, 5, 6),
              ),
              decoration: BoxDecoration(
                color: AppColors.backgroundActiveColor,
                borderRadius:
                BorderRadius.circular(scaleFor(6, 7, 8)),
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: AppColors.activeTextColor,
                  fontSize: valueSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
                : Text(
              value,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: valueSize,
                fontWeight: FontWeight.w600,
                color: AppColors.textColors,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Icon(
              isPassword
                  ? (isVisible ? Icons.visibility : Icons.visibility_off)
                  : Icons.edit,
              size: scaleFor(16, 17, 18),
              color: AppColors.textColors.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
