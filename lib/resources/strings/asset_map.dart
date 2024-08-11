import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

const supportedLocales = [Locale("tr")];

@lazySingleton
class AssetMap {
  late Map<String, dynamic> _data;

  init() async {
    final List<String> assets = await Future.wait([
      rootBundle.loadString('assets/strings/tr.json'),
    ]);
    _data = json.decode(assets[0]);
  }

  String? operator [](String? key) => _data[key];
}
