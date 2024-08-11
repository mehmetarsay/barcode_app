import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import 'package:barcode_app/locator.dart';
import 'package:barcode_app/resources/d_text_styles.dart';

part 'close_button.g.dart';

@swidget
Widget _xButton() => IconButton(
      icon: const Icon(Icons.close),
      onPressed: navigator.goBack,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );

@swidget
Widget _goBackButton() => IconButton(icon: Icon(Icons.adaptive.arrow_back), onPressed: navigator.goBack);

@swidget
Widget _titleBar(String title, {Leading? leading}) => Stack(
      alignment: Alignment.center,
      children: [
        if (leading != null) Align(alignment: Alignment.centerRight, child: leading.wb()),
        Text(title, style: DTextStyles.title),
      ],
    );

enum Leading {
  none(SizedBox.new),
  // back(GoBackButton.new),
  // close(XButton.new),
  ;

  final Widget Function() wb;

  const Leading(this.wb);
}
