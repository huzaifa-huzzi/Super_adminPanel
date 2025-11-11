import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  final scrollController = ScrollController();

  /// For Calendar
  var selectedDate = Rxn<DateTime>();
  var visibleMonth = DateTime.now().obs;
  var selectedMonth = DateTime.now().month.obs;

  /// For Weekly Leads Chart
  final values = <int>[].obs;
  final days = <String>[].obs;
  final dates = <String>[].obs;
  final weeks = <String>[].obs;
  var selectedIndex = 0.obs;

  final months = const [
    "Jan","Feb","Mar","Apr","May","Jun",
    "Jul","Aug","Sep","Oct","Nov","Dec"
  ];

  double get itemWidth => 90;

  @override
  void onInit() {
    super.onInit();
    final today = DateTime.now();
    selectedDate.value = DateTime(today.year, today.month, today.day);


    _generateWeeks(selectedDate.value!);

    final defaultIndex = weeks.indexOf("This Week");
    if (defaultIndex != -1) {
      selectedIndex.value = defaultIndex;
      _generateWeekData(defaultIndex);
    }
  }

  /// ---------------- Calendar Functions ---------------- ///
  void selectDate(DateTime date) {
    selectedDate.value = date;
    visibleMonth.value = DateTime(date.year, date.month, 1);
    selectedMonth.value = date.month;

    _generateWeeks(date);

    final defaultIndex = weeks.indexOf("This Week");
    if (defaultIndex != -1) {
      selectedIndex.value = defaultIndex;
      _generateWeekData(defaultIndex);
    }
  }

  void setMonth(int index) {
    selectedMonth.value = index + 1;
    visibleMonth.value = DateTime(visibleMonth.value.year, selectedMonth.value, 1);
  }

  /// ---------------- Weekly Chart Functions ---------------- ///

  void _generateWeeks(DateTime baseDate) {
    weeks.clear();


    final currentStart = baseDate.subtract(Duration(days: baseDate.weekday - 1));


    DateTime start = DateTime(baseDate.year, baseDate.month - 1, 1);


    start = DateTime(start.year, start.month, 1);


    while (start.isBefore(currentStart)) {
      final end = start.add(const Duration(days: 6));
      weeks.add("${start.day} ${_month(start.month)} - ${end.day} ${_month(end.month)}");
      start = start.add(const Duration(days: 7));
    }


    weeks.add("This Week");


    start = currentStart.add(const Duration(days: 7));

    final endNext = DateTime(baseDate.year, baseDate.month + 1, 0);

    while (start.isBefore(endNext) || start.isAtSameMomentAs(endNext)) {
      final end = start.add(const Duration(days: 6));
      weeks.add("${start.day} ${_month(start.month)} - ${end.day} ${_month(end.month)}");
      start = start.add(const Duration(days: 7));
    }
  }

  void _generateWeekData(int index) {
    if (index < 0 || index >= weeks.length) return;

    final baseDate = selectedDate.value ?? DateTime.now();
    final currentStart = baseDate.subtract(Duration(days: baseDate.weekday - 1));

    DateTime start;

    if (weeks[index] == "This Week") {
      start = currentStart;
    } else {

      final pattern = RegExp(r'^(\d{1,2})\s+([A-Za-z]{3})');
      final match = pattern.firstMatch(weeks[index]);
      if (match != null) {
        final startDay = int.tryParse(match.group(1)!) ?? 1;
        final monthAbbrev = match.group(2)!;
        final startMonthIndex = months.indexOf(monthAbbrev);


        final startMonth = startMonthIndex >= 0 ? startMonthIndex + 1 : baseDate.month;


        start = DateTime(baseDate.year, startMonth, startDay);
      } else {

        start = currentStart;
      }
    }

    final today = DateTime.now();
    final valuesTemp = <int>[];
    final daysTemp = <String>[];
    final datesTemp = <String>[];

    final weekDays = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"];

    for (int i = 0; i < 7; i++) {
      final d = start.add(Duration(days: i));

      if (d.isAfter(today)) {
        valuesTemp.add(0);
      } else {
        valuesTemp.add((100 + d.day * 5) % 350);
      }

      daysTemp.add(weekDays[i]);
      datesTemp.add("${d.day} ${_month(d.month)}");
    }

    values.assignAll(valuesTemp);
    days.assignAll(daysTemp);
    dates.assignAll(datesTemp);
  }

  void selectWeek(int index) {
    selectedIndex.value = index;
    _generateWeekData(index);
  }

  void scrollToPrevious() {
    final offset = scrollController.offset - itemWidth;
    scrollController.animateTo(
      offset < 0 ? 0 : offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void scrollToNext() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final offset = scrollController.offset + itemWidth;
    scrollController.animateTo(
      offset > maxScroll ? maxScroll : offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  String _month(int m) {

    if (m <= 0) return months[0];
    final idx = ((m - 1) % 12).abs();
    return months[idx];
  }
}
