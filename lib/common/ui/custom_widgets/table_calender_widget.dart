import 'package:starter/common/blocs/app_language/app_language_bloc.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class TableCalenderWidget extends StatefulWidget {
  TableCalenderWidget({
    super.key,
    required this.onDayClick,
    required this.toHighlight,
    required this.focusedDay,
    required this.selectedDay,
    required this.color,
  });

  dynamic onDayClick;
  final List<DateTime> toHighlight;
  DateTime focusedDay;
  DateTime selectedDay;
  final Color color;

  @override
  State<TableCalenderWidget> createState() => _TableCalenderWidgetState();
}

class _TableCalenderWidgetState extends State<TableCalenderWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final lang =
        BlocProvider.of<AppLanguageBloc>(context).state.locale.languageCode;

    return TableCalendar(
      locale: lang,
      calendarStyle: const CalendarStyle(
        todayTextStyle: TextStyle(color: AppColors.primary_400),
        selectedTextStyle: TextStyle(color: Colors.black),
        selectedDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            colors: AppColors.tableCalenderFocusedDayGradiantColors,
          ),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
        canMarkersOverflow: false,
      ),
      headerStyle: HeaderStyle(
        titleCentered: false,
        leftChevronMargin: const EdgeInsets.symmetric(horizontal: 0.0),
        rightChevronMargin: const EdgeInsets.symmetric(horizontal: 0.0),
        leftChevronIcon: lang == "ar"
            ? const Icon(
                Ionicons.chevron_forward_outline,
                color: AppColors.primary_500,
              )
            : const Icon(
                Ionicons.chevron_back_outline,
                color: AppColors.primary_500,
              ),
        rightChevronIcon: lang == "ar"
            ? const Icon(
                Ionicons.chevron_back_outline,
                color: AppColors.primary_500,
              )
            : const Icon(
                Ionicons.chevron_forward_outline,
                color: AppColors.primary_500,
              ),
        titleTextStyle: TextStyles.regular(
          color: AppColors.blackColor,
          fontSize: Dimensions.xxxLarge,
        ),
        formatButtonVisible: false,
        formatButtonShowsNext: false,
      ),
      firstDay: DateTime.utc(2017, 1, 1),
      lastDay: DateTime.utc(2025, 12, 31),
      focusedDay: widget.focusedDay,
      calendarFormat: CalendarFormat.month,
      onDaySelected: (selectedDay, focusedDay) {
        widget.onDayClick(selectedDay, focusedDay);
      },
      selectedDayPredicate: (day) {
        if (widget.toHighlight.contains(DateFormat('yyyy-MM-dd')
            .parse(DateFormat('yyyy-MM-dd').format(widget.selectedDay)))) {
          return isSameDay(widget.selectedDay, day);
        } else {
          return false;
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        widget.focusedDay = focusedDay;
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, focusedDay) {
          for (DateTime d in widget.toHighlight) {
            if (isSameDay(day, d)) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingDimensions.normal),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColorsSolid4Default,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: DateFormat('yyyy-MM-dd').parse(
                                  DateFormat('yyyy-MM-dd')
                                      .format(widget.selectedDay)) ==
                              DateFormat('yyyy-MM-dd')
                                  .parse(DateFormat('yyyy-MM-dd').format(day))
                          ? TextStyle(color: widget.color)
                          : TextStyles.regular(
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              );
            }
          }
          return null;
        },
      ),
    );
  }
}
