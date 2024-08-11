import 'package:barcode_app/resources/d_colors.dart';
import 'package:barcode_app/widget/view_builder.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'loading_observer.g.dart';

@swidget
Widget _loadingObserver({required final Widget child}) => ValueListenableBuilder<bool>(
      valueListenable: loading,
      builder: (_, isLoading, __) =>
          isLoading ? Stack(children: [child, const Barrier(color: DColors.barrier), const CenterLoading()]) : child,
    );
