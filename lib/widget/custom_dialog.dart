import 'package:barcode_app/resources/d_text_styles.dart';
import 'package:barcode_app/resources/decorations.dart';
import 'package:barcode_app/resources/dimens.dart';
import 'package:barcode_app/widget/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'custom_dialog.g.dart';

@swidget
Widget customDialogView({
  String? title,
  String? description,
  Widget? header,
  String? positiveButtonText,
  String? negativeButtonText,
  Function()? positiveButtonAction,
  Function()? negativeButtonAction,
  bool persistent = false,
}) =>
    WillPopScope(
      onWillPop: () async => persistent,
      child: Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: popupBoxDecoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(top: DDimens.l, left: DDimens.l, right: DDimens.l, bottom: DDimens.m),
                child: Column(
                  children: <Widget>[
                    if (header != null) header,
                    if (title != null) ...[
                      Text(title, style: DTextStyles.darkBold, textAlign: TextAlign.center),
                      const SizedBox(height: DDimens.m),
                    ],
                    if (description != null) ...[
                      Text(description, textAlign: TextAlign.center, style: DTextStyles.darkLight),
                      const SizedBox(height: DDimens.l),
                    ],
                    Row(
                      children: [
                        if (negativeButtonText != null && negativeButtonAction != null)
                          Expanded(
                            child: RoundedButtonView(
                              light: true,
                              text: negativeButtonText,
                              mini: positiveButtonText != null && positiveButtonAction != null,
                              onPressed: negativeButtonAction,
                            ),
                          ),
                        if (negativeButtonText != null) const SizedBox(width: DDimens.m),
                        if (positiveButtonText != null && positiveButtonAction != null)
                          Expanded(
                            child: RoundedButtonView(
                              text: positiveButtonText,
                              onPressed: positiveButtonAction,
                              mini: negativeButtonText != null && negativeButtonAction != null,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
