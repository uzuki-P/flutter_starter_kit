import 'dart:io';
import 'dart:ui';
import 'dart:math';

import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_starter_kit/generated/i18n.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  /// Return text with new line char.
  ///
  /// ex: ['hello', 'world']
  /// return: hello (newLine) world
  static String getNewLineString(List<String> lines) {
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < lines.length - 1; i++) {
      sb.write(lines[i] + "\n");
    }
    sb.write(lines[lines.length - 1]);

    return sb.toString();
  }

  /// Open URL
  static launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// get next locale
  static Locale getNextLocale(Locale currentLocale) {
    final localeList = S.delegate.supportedLocales;
    final Locale next = localeList[
        ((localeList.indexOf(currentLocale) + 1) % localeList.length)];
    return next;
  }

  static double radToDegree(double rad) {
    return rad * pi / 180;
  }

  static final FormFieldValidator<String> fieldIsRequiredValidator = (value) {
    if (value.isEmpty) {
      return 'Field is required';
    }
    return null;
  };

  static String validateBreakTime(String time) {
    final int hour = int.parse(time.split(":")[0]);
    final int minutes = int.parse(time.split(":")[1]);

    final selectedTime = DateTime(2020, 01, 01, hour, minutes);

    final startBreak = DateTime(2020, 01, 01, 12, 00);
    final endBreak = DateTime(2020, 01, 01, 13, 30);

    if (selectedTime.isAfter(startBreak) && selectedTime.isBefore(endBreak)) {
      return 'Jam istirahat';
    }

    return null;
  }

  static String validateStartTimeIsAfterEndTime(
    String startTime,
    String endTime,
  ) {
    final int startHour = int.parse(startTime.split(":")[0]);
    final int startMinutes = int.parse(startTime.split(":")[1]);
    final startDateTime = DateTime(2020, 01, 01, startHour, startMinutes);

    final int endHour = int.parse(endTime.split(":")[0]);
    final int endMinutes = int.parse(endTime.split(":")[1]);
    final endDateTime = DateTime(2020, 01, 01, endHour, endMinutes);

    if (endDateTime.isBefore(startDateTime)) {
      return 'Jam Awal > Akhir';
    }

    return null;
  }

  static Color getStripedColorList(int index) {
    return index.isOdd ? Colors.grey[50] : Colors.grey[200];
  }

  static String getDateFromDateTime(String dateTime) {
    final parsed = DateTime.parse(dateTime);
    return "${parsed.day}/${parsed.month}/${parsed.year}";
  }

  static String getTimeFromDateTime(String dateTime) {
    final parsed = DateTime.parse(dateTime);
    return parsed.hour.toString().padLeft(2, '0') +
        ":" +
        parsed.minute.toString().padLeft(2, '0');
  }

  static String dateTimeToDatabaseDate(DateTime dateTime) {
    if (dateTime == null) return null;
    return DateFormat('y-MM-d').format(dateTime).toString();
  }

  static Future<String> getFileNameWithExtension(File file) async {
    if (await file.exists()) {
      //To get file name without extension
      //path.basenameWithoutExtension(file.path);

      //return file with file extension
      return path.basename(file.path);
    } else {
      return null;
    }
  }
}
