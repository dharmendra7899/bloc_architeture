import 'package:counter_demo_bloc/res/constants/messages.dart';
import 'package:counter_demo_bloc/res/widgets/context_extension.dart';
import 'package:counter_demo_bloc/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatDate(String inputDate, String formatDate) {
    try {
      final parsedDate = DateFormat("dd-MM-yyyy").parse(inputDate);
      return DateFormat(formatDate).format(parsedDate);
    } catch (e) {
      return "";
    }
  }

  static void toastMessage(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(milliseconds: 3000),
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 60,
            left: 16,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: appColors.lightColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  message,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: appColors.titleColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  static String formatTime(DateTime time) {
    return "${time.hour > 12
        ? time.hour - 12
        : time.hour == 0
        ? 12
        : time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}";
  }

  static String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map(
          (word) =>
              word.isNotEmpty
                  ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                  : '',
        )
        .join(' ');
  }

  DateTime selectedDateTime = DateTime.now();

  void pickDate({
    DateTime? firstDay,
    DateTime? lastDate,
    DateTime? dateForEditProfile,
    DateTime? selectedDateAndTime,
    required DateTime focusDate,
    required Function onDateSelected,
  }) {
    selectedDateTime = selectedDateAndTime ?? DateTime.now();
    CalendarDatePicker(
      initialDate: dateForEditProfile ?? firstDay ?? DateTime.now(),
      firstDate: firstDay ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 18 * 365)),
      onDateChanged: (DateTime value) {
        selectedDateTime = value;
      },
    );
  }

  static String? validatePassport(String? value) {
    final passportRegExp = RegExp(r'^[A-PR-WYa-pr-wy][0-9]{7,8}$');
    if (value == null || value.trim().isEmpty) {
      return Messages.PASSPORT_REQ;
    } else if (!passportRegExp.hasMatch(value.trim().toUpperCase())) {
      return Messages.PASSPORT_VALID;
    }
    return null;
  }

  static String? validateMobileNumber(String? value) {
    final mobileRegExp = RegExp(r'^[6-9]\d{9}$');
    if (value == null || value.isEmpty) {
      return Messages.PHONE_REQ;
    } else if (!mobileRegExp.hasMatch(value)) {
      return Messages.PHONE_VALID;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final emailRegExp = RegExp(
      r'^([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$',
      caseSensitive: false,
    );
    if (value == null || value.isEmpty) {
      return Messages.EMAIL_REQ;
    } else if (!emailRegExp.hasMatch(value)) {
      return Messages.EMAIL_VALID;
    }
    return null;
  }
}
