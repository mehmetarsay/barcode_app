import 'package:barcode_app/locator.config.dart';
import 'package:barcode_app/resources/strings/asset_map.dart';
import 'package:barcode_app/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@injectableInit
configureDependencies() => sl.init();

init() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await sl<AssetMap>().init();
}

GetIt get sl => GetIt.I;
NavigatorService get navigator => sl<NavigatorService>();
