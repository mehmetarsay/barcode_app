extension StringNullableExtensions on String? {
  bool parseBool() => this?.toLowerCase() == 'true';

  bool get isValidUrl {
    try {
      return Uri.parse(this!).host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  String get initial => this == null || this!.isEmpty == true ? '' : '${this!.substring(0, 1)}.';
}
