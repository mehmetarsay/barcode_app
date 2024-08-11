// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_dialog.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class CustomDialogView extends StatelessWidget {
  const CustomDialogView({
    Key? key,
    this.title,
    this.description,
    this.header,
    this.positiveButtonText,
    this.negativeButtonText,
    this.positiveButtonAction,
    this.negativeButtonAction,
    this.persistent = false,
  }) : super(key: key);

  final String? title;

  final String? description;

  final Widget? header;

  final String? positiveButtonText;

  final String? negativeButtonText;

  final dynamic Function()? positiveButtonAction;

  final dynamic Function()? negativeButtonAction;

  final bool persistent;

  @override
  Widget build(BuildContext _context) => customDialogView(
        title: title,
        description: description,
        header: header,
        positiveButtonText: positiveButtonText,
        negativeButtonText: negativeButtonText,
        positiveButtonAction: positiveButtonAction,
        negativeButtonAction: negativeButtonAction,
        persistent: persistent,
      );
}
