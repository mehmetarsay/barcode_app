import 'package:flutter/material.dart';

import 'd_colors.dart';

final theme = ThemeData(
  primaryColor: DColors.primary,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: false,
  fontFamily: 'gotham',
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: DColors.primary,
    foregroundColor: Colors.white,
  ),
  drawerTheme: const DrawerThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: DColors.primary),
    titleSpacing: 0,
    centerTitle: true,
    elevation: 0,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: DColors.primary,
    primary: DColors.primary,
    secondary: DColors.primary,
    background: Colors.white,
  ),
);
