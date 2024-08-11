import 'package:barcode_app/resources/d_colors.dart';
import 'package:barcode_app/resources/d_text_styles.dart';
import 'package:barcode_app/resources/dimens.dart';
import 'package:barcode_app/resources/duration.dart';
import 'package:barcode_app/widget/view_builder.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'rounded_button.g.dart';

const _radius = BorderRadius.all(Radius.circular(DDimens.button));

@swidget
Widget _roundedButtonView({
  required dynamic text,
  required void Function()? onPressed,
  ValueNotifier<bool>? enable,
  bool light = false,
  bool fill = false,
  bool mini = false,
  double? height,
  int? remaining,
  int? total,
  Color2 colors = Color2.primary,
  Widget? leading,
}) =>
    SizedBox(
      height: height,
      child: enable == null
          ? _Button(light, fill, mini, onPressed, text, remaining, total, colors, leading)
          : ValueListener<bool>(
              listenable: enable,
              builder: (enabled) {
                final pressed = (onPressed == null || !enabled) ? null : onPressed;
                return _Button(light, fill, mini, pressed, text, remaining, total, colors, leading);
              },
            ),
    );

@swidget
Widget __button(bool light, bool fill, bool mini, void Function()? onPressed, dynamic text, int? remaining, int? total,
    Color2 colors, Widget? leading) {
  Widget button = leading != null
      ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [leading, const SizedBox(width: DDimens.sm), _text(text, mini)],
        )
      : _text(text, mini);

  bool hasRemaining = remaining != null && total != null;

  if (hasRemaining) {
    button = _remainingCount(button, light, mini, remaining, colors);
    button = _remainingProgress(total, remaining, colors.first, button);
    colors = colors.withItem1(Colors.white);
  }

  button = TextButton(style: _style(light, mini, colors, hasRemaining), onPressed: onPressed, child: button);
  if (fill) button = SizedBox(width: double.infinity, child: button);
  return button;
}

Widget _text(dynamic text, bool mini) {
  if (text is Widget) {
    return text;
  } else if (text is String) {
    return Text(
      text,
      style: DTextStyles.button.copyWith(fontSize: mini ? 14.0 : 20.0),
      textAlign: TextAlign.center,
      maxLines: 1,
    );
  } else {
    throw Exception('Invalid text type');
  }
}

Widget _remainingCount(Widget button, bool light, bool mini, int remaining, Color2 colors) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        button,
        const SizedBox(width: DDimens.m),
        _RemainingCircle(light, mini, remaining, colors),
      ],
    );

@swidget
Widget __remainingCircle(bool light, bool mini, int remaining, Color2 colors) => CircleAvatar(
      backgroundColor: light ? colors.first : Colors.white,
      radius: mini ? 14 : 16,
      child: Text(
        remaining.toString(),
        style: DTextStyles.button.copyWith(color: light ? Colors.white : colors.first, fontSize: mini ? 12.0 : 16.0),
        textAlign: TextAlign.center,
      ),
    );

Widget _remainingProgress(int total, int remaining, Color tempColor, Widget button) => Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: _radius,
          child: TweenAnimationBuilder<double>(
            duration: second,
            curve: Curves.linear,
            tween: Tween<double>(begin: (total - remaining - 1) / (total - 1), end: (total - remaining) / (total - 1)),
            builder: (context, value, _) => LinearProgressIndicator(
              color: tempColor,
              backgroundColor: tempColor.withOpacity(0.8),
              value: value,
              minHeight: 56,
            ),
          ),
        ),
        button,
      ],
    );

ButtonStyle _style(bool light, bool mini, Color2 colors, bool hasRemaining) => ButtonStyle(
      backgroundColor: _backgroundColor(light, colors),
      foregroundColor: _foregroundColor(light, colors),
      padding: _padding(mini, hasRemaining),
      shape: _shape(light, colors),
    );

WidgetStateProperty<OutlinedBorder?> _shape(bool light, Color2 colors) => WidgetStateProperty.resolveWith(
      (s) => RoundedRectangleBorder(
        side: s.contains(WidgetState.disabled) || !light ? BorderSide.none : BorderSide(color: colors.first),
        borderRadius: _radius,
      ),
    );

WidgetStateProperty<EdgeInsetsGeometry?> _padding(bool mini, bool hasRemaining) => WidgetStateProperty.all(
      hasRemaining
          ? EdgeInsets.zero
          : mini
              ? const EdgeInsets.symmetric(vertical: DDimens.xxs, horizontal: DDimens.s)
              : const EdgeInsets.symmetric(vertical: DDimens.s + DDimens.xs, horizontal: DDimens.m),
    );

WidgetStateProperty<Color?> _foregroundColor(bool light, Color2 colors) => WidgetStateProperty.resolveWith(
      (s) => s.contains(WidgetState.disabled) || !light ? Colors.white : colors.first,
    );

WidgetStateProperty<Color?> _backgroundColor(bool light, Color2 colors) => WidgetStateProperty.resolveWith(
      (s) => s.contains(WidgetState.disabled)
          ? DColors.grey2
          : light
              ? colors.second
              : colors.first,
    );
