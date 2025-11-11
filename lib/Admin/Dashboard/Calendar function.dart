import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_adminPanel/Admin/Dashboard/DashboardController.dart';
import 'package:super_adminPanel/Resources/Colors.dart';

/// ------------------ Show Calendar Dialog ------------------ ///
void showCustomCalendarDialog(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  //  Responsive sizing
  double dialogWidth = screenWidth * 0.9;
  double dialogHeight = screenHeight * 0.8;

  if (screenWidth > 1200) {
    //  Desktop
    dialogWidth = 700;
    dialogHeight = 550;
  } else if (screenWidth > 800) {
    //  Tablet
    dialogWidth = 600;
    dialogHeight = 500;
  }

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(12),
      content: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: CalendarBody(),
      ),
    ),
  );
}

/// ------------------ Calendar Body ------------------ ///
class CalendarBody extends StatelessWidget {
  CalendarBody({Key? key}) : super(key: key);

  final DashBoardController controller = Get.put(DashBoardController());
  final weekDays = const ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];

  @override
  Widget build(BuildContext context) {


    // Screen info
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    return Column(
      children: [
        /// ---------- Top Presets ----------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _presetBox("Today", () {
                    final today = DateTime.now();
                    controller.selectDate(DateTime(today.year, today.month, today.day));
                  }),
                  _presetBox("Last 7 Days", () {
                    final today = DateTime.now();
                    controller.selectDate(today.subtract(const Duration(days: 6)));
                  }),
                  _presetBox("Last Month", () {
                    final today = DateTime.now();
                    final lastMonth = DateTime(today.year, today.month - 1, 1);
                    controller.visibleMonth.value = lastMonth;
                    controller.selectedDate.value = null;
                  }),
                ],
              ),
            ),
            _iconBox(Icons.close, context),
          ],
        ),

        SizedBox(height: screenHeight * 0.012),
        Divider(color: AppColors.dividerColor, thickness: 1),
        SizedBox(height: screenHeight * 0.01),

        /// ---------- Calendar + Month Picker ----------
        Expanded(
          child: isMobile
              ? Column(
            children: [
              _yearSelector(),
              SizedBox(height: screenHeight * 0.02),
              // Calendar
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _weekHeader(),
                    SizedBox(height: screenHeight * 0.01),
                    Expanded(
                      child: Obx(() => _buildMonthGrid(
                        context,
                        controller.visibleMonth.value,
                        controller.selectedDate.value,
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              SizedBox(
                height: screenHeight * 0.20,
                child: const MonthPicker(),
              ),
            ],
          )
              : Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _yearSelector(),
                    SizedBox(height: screenHeight * 0.06),
                    _weekHeader(),
                    Expanded(
                      child: Obx(() => _buildMonthGrid(
                        context,
                        controller.visibleMonth.value,
                        controller.selectedDate.value,
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.015),
              const Expanded(flex: 1, child: MonthPicker()),
            ],
          ),
        ),
      ],
    );
  }

  /// Year Selector Row
  Widget _yearSelector() {
    return Obx(() {
      final year = controller.visibleMonth.value.year;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Arrow
          GestureDetector(
            onTap: () {
              final prevYear = year - 1;
              controller.visibleMonth.value =
                  DateTime(prevYear, controller.visibleMonth.value.month, 1);
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.backgroundOfSearchBar,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.chevron_left, size: 20),
            ),
          ),

          // Year Text
          Expanded(
            child: Center(
              child: Text(
                "$year",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Right Arrow
          GestureDetector(
            onTap: () {
              final nextYear = year + 1;
              controller.visibleMonth.value =
                  DateTime(nextYear, controller.visibleMonth.value.month, 1);
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.backgroundOfSearchBar,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.chevron_right, size: 20),
            ),
          ),
        ],
      );
    });
  }

  /// Week Days Row
  Widget _weekHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekDays
          .map((day) => Expanded(
        child: Center(
          child: FittedBox(
            child: Text(
              day,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ))
          .toList(),
    );
  }

  /// Calendar Grid (Dates)
  Widget _buildMonthGrid(BuildContext context, DateTime visibleMonth, DateTime? selectedDate) {
    final firstDay = DateTime(visibleMonth.year, visibleMonth.month, 1);
    final startIndex = firstDay.weekday % 7;
    final daysInMonth = DateTime(visibleMonth.year, visibleMonth.month + 1, 0).day;
    const totalCells = 42;

    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    final cells = List<DateTime?>.generate(totalCells, (i) {
      final dayNum = i - startIndex + 1;
      if (dayNum < 1 || dayNum > daysInMonth) return null;
      return DateTime(visibleMonth.year, visibleMonth.month, dayNum);
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return GridView.builder(
      itemCount: totalCells,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: isMobile ? 1.0 : 1.2,
      ),
      itemBuilder: (context, idx) {
        final dt = cells[idx];
        if (dt == null) return const SizedBox();

        final isSelected = selectedDate != null &&
            dt.year == selectedDate.year &&
            dt.month == selectedDate.month &&
            dt.day == selectedDate.day;

        final isPast = dt.isBefore(todayDate);

        Color textColor = Colors.black;
        if (isSelected) {
          textColor = Colors.white;
        } else if (isPast) {
          textColor = AppColors.captionsColor;
        }

        return GestureDetector(
          onTap: () => controller.selectDate(dt),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.appBarColor : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FittedBox(
                child: Text(
                  "${dt.day}",
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Preset Button
  Widget _presetBox(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfSearchBar,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
        ),
      ),
    );
  }

  /// Small Icon Box
  Widget _iconBox(IconData icon, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfSearchBar,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: AppColors.captionsColor, size: 20),
      ),
    );
  }
}

/// Month Picker
class MonthPicker extends StatelessWidget {
  const MonthPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashBoardController>();

    return Obx(() {
      return ListWheelScrollView.useDelegate(
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) => controller.setMonth(index),
        controller: FixedExtentScrollController(
          initialItem: controller.selectedMonth.value - 1,
        ),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            if (index < 0 || index >= controller.months.length) return null;

            final isSelected = controller.selectedMonth.value == index + 1;
            return Center(
              child: Text(
                controller.months[index],
                style: GoogleFonts.poppins(
                  fontSize: isSelected ? 20 : 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                  color: isSelected ? Colors.black : Colors.grey,
                ),
              ),
            );
          },
          childCount: controller.months.length,
        ),
      );
    });
  }
}
