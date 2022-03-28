import 'dart:math';

import 'package:get/get.dart';

/// Returns height & width percentage based on [this] value.
extension PercentSized on double {
  double get hp => (Get.height * (this / 100));

  double get wp => (Get.width * (this / 100));
}

/// Returns responsive sp value for text sizes.
extension ResponsiveText on double {
  double get sp => Get.width / 100 * (this / 3);
}

/// Returns responsive sp value for text sizes.
extension Capitalization on String {
  String get toTitleCase => replaceFirst(this[0], this[0].toUpperCase());
}

/// Returns file size based on bytes passed.
extension FileSize on int {
  String get sizeInHigherBytes {
    if (this <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(this) / log(1024)).floor();
    return ((this / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
  }
}