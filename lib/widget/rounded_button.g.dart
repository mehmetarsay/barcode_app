// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rounded_button.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class RoundedButtonView extends StatelessWidget {
  const RoundedButtonView({
    Key? key,
    required this.text,
    required this.onPressed,
    this.enable,
    this.light = false,
    this.fill = false,
    this.mini = false,
    this.height,
    this.remaining,
    this.total,
    this.colors = Color2.primary,
    this.leading,
  }) : super(key: key);

  final dynamic text;

  final void Function()? onPressed;

  final ValueNotifier<bool>? enable;

  final bool light;

  final bool fill;

  final bool mini;

  final double? height;

  final int? remaining;

  final int? total;

  final Color2 colors;

  final Widget? leading;

  @override
  Widget build(BuildContext _context) => _roundedButtonView(
        text: text,
        onPressed: onPressed,
        enable: enable,
        light: light,
        fill: fill,
        mini: mini,
        height: height,
        remaining: remaining,
        total: total,
        colors: colors,
        leading: leading,
      );
}

class _Button extends StatelessWidget {
  const _Button(
    this.light,
    this.fill,
    this.mini,
    this.onPressed,
    this.text,
    this.remaining,
    this.total,
    this.colors,
    this.leading, {
    Key? key,
  }) : super(key: key);

  final bool light;

  final bool fill;

  final bool mini;

  final void Function()? onPressed;

  final dynamic text;

  final int? remaining;

  final int? total;

  final Color2 colors;

  final Widget? leading;

  @override
  Widget build(BuildContext _context) => __button(
        light,
        fill,
        mini,
        onPressed,
        text,
        remaining,
        total,
        colors,
        leading,
      );
}

class _RemainingCircle extends StatelessWidget {
  const _RemainingCircle(
    this.light,
    this.mini,
    this.remaining,
    this.colors, {
    Key? key,
  }) : super(key: key);

  final bool light;

  final bool mini;

  final int remaining;

  final Color2 colors;

  @override
  Widget build(BuildContext _context) => __remainingCircle(
        light,
        mini,
        remaining,
        colors,
      );
}
