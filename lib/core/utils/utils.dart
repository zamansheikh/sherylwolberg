import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:workflowx/core/themes/app_colors.dart';

class Utils {
  
Widget svgViewer({
  required String asset,
  double height = 24.0,
  double width = 24.0,
  Color? color,
}) {
  return SvgPicture.asset(
    asset,
    height: height,
    width: width,
    colorFilter:
        color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
  );
}

void showSnackBar({
  required String? message,
  required bool isSucess,
}) {
  Get.snackbar(
    isSucess ? "Success" : "Error",
    message ?? (isSucess ? "No error Found" : "Something went wrong"),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.instance.grey,
    colorText: AppColors.instance.primaryTextColor,
  );
}



void llg(dynamic message) {
  var toString = message.toString();
  if (kDebugMode) {
    print("Logged from Here: $toString");
  }
}

String checkNull(String? value, String defaultValue) {
  return value ?? defaultValue;
}

static String imageUrl(String? url) {
  if (url == null || url.isEmpty) {
    return "https://thispersondoesnotexist.com/";
  } else {
    if (url.startsWith("http")) {
      return url;
    }
    // print("Image URL: ${ApiConstant.imageBaseUrl + url}");
    return "http://192.168.0.125:3500/$url";
  }
}

String nullSafe(String? value) {
  return value ?? "Null";
}

String secondToFormattedTime(int second) {
  int hours = second ~/ 3600;
  int minutes = (second % 3600) ~/ 60;
  int seconds = second % 60;

  if (hours > 0) {
    return "${hours}h ${minutes}m";
  } else if (minutes > 0) {
    return "${minutes}m";
  } else {
    return "${seconds}s";
  }
}

String secondToFormattedTimeWithSecond(int second) {
  int hours = second ~/ 3600;
  int minutes = (second % 3600) ~/ 60;
  int seconds = second % 60;

  if (hours > 0) {
    return "${hours}h ${minutes}m ${seconds}s";
  } else if (minutes > 0) {
    return "${minutes}m ${seconds}s";
  } else {
    return "${seconds}s";
  }}
}
