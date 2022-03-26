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