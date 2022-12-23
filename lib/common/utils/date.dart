import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 格式化时间
String duTimeLineFormat(DateTime dt) {
  var now = DateTime.now();
  var difference = now.difference(dt);

  // 1天内
  if (difference.inHours < 24) {
    return "${difference.inHours} hours ago";
  }
  // 30天内
  else if (difference.inDays < 30) {
    return "${difference.inDays} days ago";
  }
  // MM-dd
  else if (difference.inDays < 365) {
    final dtFormat = new DateFormat('MM-dd');
    return dtFormat.format(dt);
  }
  // yyyy-MM-dd
  else {
    final dtFormat = new DateFormat('yyyy-MM-dd');
    var str = dtFormat.format(dt);
    return str;
  }
}

String bookPublicationTimeFormat(String time){
  var date = DateUtil.getDateTime(time);
  String week = DateUtil.getWeekday(date,short: true);
  String dateStr = DateUtil.formatDate(date,format: 'MM/dd@HH:mm');

  return '$week $dateStr';
}

String getWeekday(DateTime? dateTime,
    {String languageCode = 'en', bool short = false}) {
  if (dateTime == null) return "";
  String weekday = "";
  switch (dateTime.weekday) {
    case 1:
      weekday = languageCode == 'zh' ? '星期一' : 'Mon';
      break;
    case 2:
      weekday = languageCode == 'zh' ? '星期二' : 'Tues';
      break;
    case 3:
      weekday = languageCode == 'zh' ? '星期三' : 'Wednes';
      break;
    case 4:
      weekday = languageCode == 'zh' ? '星期四' : 'Thurs';
      break;
    case 5:
      weekday = languageCode == 'zh' ? '星期五' : 'Fri';
      break;
    case 6:
      weekday = languageCode == 'zh' ? '星期六' : 'Satur';
      break;
    case 7:
      weekday = languageCode == 'zh' ? '星期日' : 'Sun';
      break;
    default:
      break;
  }
  return languageCode == 'zh'
      ? (short ? weekday.replaceAll('星期', '周') : weekday)
      : weekday.substring(0, short ? 3 : weekday.length);
}
