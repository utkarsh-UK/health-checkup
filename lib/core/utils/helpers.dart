class Helpers {
  /// Converts int [freq] to Ordinal String.
  static String getFrequency(int freq) {
    switch (freq) {
      case 1:
        return 'once';
      case 2:
        return 'twice';
      case 3:
        return 'thrice';
      default:
        return 'once';
    }
  }

  /// Converts String [freq] to int.
  static int fromFrequency(String freq) {
    switch (freq) {
      case 'ONCE':
        return 1;
      case 'TWICE':
        return 2;
      case 'THRICE':
        return 3;
      default:
        return 1;
    }
  }

  static String getOrdinalNumbers(int no) {
    switch (no) {
      case 0:
        return 'First';
      case 1:
        return 'Second';
      case 2:
        return 'Third';
      default:
        return 'First';
    }
  }
}
