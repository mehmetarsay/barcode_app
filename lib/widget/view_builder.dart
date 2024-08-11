import 'package:barcode_app/locator.dart';
import 'package:barcode_app/network/api.dart';
import 'package:barcode_app/resources/d_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:stacked/stacked.dart';

part 'view_builder.g.dart';

@swidget
Widget _valueListener<T>({required ValueListenable<T> listenable, required Widget Function(T) builder}) =>
    ValueListenableBuilder<T>(valueListenable: listenable, builder: (_, value, __) => builder(value));

@swidget
Widget _modalProgress({Color busyColor = DColors.barrier, required bool isLoading, required Widget child}) =>
    !isLoading ? child : Stack(children: [child, Barrier(color: busyColor), const CenterLoading()]);

@swidget
Widget _centerLoading() => const Center(child: Loading());

@swidget
Widget _loading() => const CircularProgressIndicator.adaptive();

@swidget
Widget _barrier({Color color = DColors.barrier}) => ModalBarrier(dismissible: false, color: color);

const silent = ObjectKey('silent');

final loading = ValueNotifier(false);

extension BaseViewModelExtensions on BaseViewModel {
  request(Function call, {Object? to, bool handleError = true, bool closeKeyboard = true}) =>
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (closeKeyboard) navigator.closeKeyboard();
        if (to != silent) {
          if (to != null) {
            setBusyForObject(to, true);
          } else {
            loading.value = true;
          }
        }
        await handling(call, handleError: handleError);
        if (to != silent) {
          if (to != null) {
            setBusyForObject(to, false);
          } else {
            loading.value = false;
          }
        }
      });
}

handling(Function call, {bool handleError = true}) async {
  try {
    await call();
  } catch (e) {
    if (handleError) Api.handleError(e, StackTrace.current);
  }
}

var nonBlockingisStart = false;
nonBlocking(Function call) async {
  if (nonBlockingisStart) return;
  nonBlockingisStart = true;
  final l = loading.value;
  try {
    loading.value = false;
    await call();
  } catch (_) {
  } finally {
    loading.value = l;
    nonBlockingisStart = false;
  }
}

blocking(Function call, {Function? onError}) async {
  loading.value = true;
  try {
    await call();
  } catch (exception) {
    if (onError != null) onError();
  }
  loading.value = false;
}

loadAsync(Function call) async {
  try {
    loading.value = true;
    var val = await call();
    loading.value = false;
    return val;
  } catch (exception) {
    loading.value = false;
    rethrow;
  }
}
