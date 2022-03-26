class Helpers {
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
}
