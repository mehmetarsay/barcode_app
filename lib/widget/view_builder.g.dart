// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_builder.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class ValueListener<T> extends StatelessWidget {
  const ValueListener({
    Key? key,
    required this.listenable,
    required this.builder,
  }) : super(key: key);

  final ValueListenable<T> listenable;

  final Widget Function(T) builder;

  @override
  Widget build(BuildContext _context) => _valueListener<T>(
        listenable: listenable,
        builder: builder,
      );
}

class ModalProgress extends StatelessWidget {
  const ModalProgress({
    Key? key,
    this.busyColor = DColors.barrier,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final Color busyColor;

  final bool isLoading;

  final Widget child;

  @override
  Widget build(BuildContext _context) => _modalProgress(
        busyColor: busyColor,
        isLoading: isLoading,
        child: child,
      );
}

class CenterLoading extends StatelessWidget {
  const CenterLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => _centerLoading();
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => _loading();
}

class Barrier extends StatelessWidget {
  const Barrier({
    Key? key,
    this.color = DColors.barrier,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext _context) => _barrier(color: color);
}
