import 'dart:io';

import 'package:barcode_app/locator.dart';
import 'package:barcode_app/resources/strings/asset_map.dart';
import 'package:barcode_app/resources/theme.dart';
import 'package:barcode_app/routing/routes.dart';
import 'package:barcode_app/widget/loading_observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'main.g.dart';

main() async {
  await init();
  runApp(BarcodeApp(Routes.products.name));
}

@swidget
Widget barcodeApp(BuildContext context, String firstRoute) {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: supportedLocales,
    theme: theme,
    builder: (_, child) {
      child = LoadingObserver(child: child!);
      return child;
    },
    navigatorKey: navigator.navigatorKey,
    navigatorObservers: [navigator.routeObserver],
    onGenerateRoute: (settings) => onGenerateRoute(settings),
    initialRoute: firstRoute,
  );
}

Route<dynamic> onGenerateRoute(RouteSettings settings) =>
    (Platform.isIOS ? CupertinoPageRoute.new : MaterialPageRoute.new)(
        settings: settings,
        builder: (_) {
          final uri = Uri.parse(settings.name!);
          final route = uri.route;
          Widget child = route.viewBuilder(uri.queryParameters['q']);
          if (route.wrap) child = Scaffold(appBar: route.appBar, body: SafeArea(child: child));
          return child;
        });
