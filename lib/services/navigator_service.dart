import 'package:barcode_app/resources/decorations.dart';
import 'package:barcode_app/resources/strings/tr.dart';
import 'package:barcode_app/routing/routes.dart';
import 'package:barcode_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NavigatorService {
  final routeObserver = RouteObserver<PageRoute>();
  final navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _currentState => navigatorKey.currentState;

  BuildContext? get _context => _currentState?.overlay?.context;

  BuildContext get context => _context!;

  double get width => MediaQuery.of(context).size.width;

  double get height => MediaQuery.of(context).size.height;

  Future<T?>? navigateTo<T>(Uri uri, {bool replace = false, bool clearStack = false}) {
    final route = uri.toString();
    if (clearStack) return _currentState?.pushNamedAndRemoveUntil(route, (r) => false);
    if (replace) return _currentState?.pushReplacementNamed(route);
    return _currentState?.pushNamed(route);
  }

  rebuildPage() {
    final name = _currentState?.widget.initialRoute;
    if (name == null) return;
    return _currentState?.pushReplacementNamed(name);
  }

  void goBack<T extends Object>([T? result]) => _currentState?.pop(result);

  void goBackUntil<T extends Object>(Routes until) => _currentState?.popUntil((r) => r.settings.name == until.name);

  bottomSheet({required Widget child, bool draggable = true, bool isDismissible = true}) => showModalBottomSheet(
        enableDrag: draggable,
        isScrollControlled: true,
        context: context,
        isDismissible: isDismissible,
        shape: bsBorder,
        builder: (context) => SafeArea(child: Padding(padding: MediaQuery.of(context).viewInsets, child: child)),
      );

  search({required SearchDelegate delegate}) => showSearch(context: context, delegate: delegate);

  dialog({
    String? title,
    String? description,
    Widget? header,
    String? negativeButtonText,
    Function()? negativeButtonAction,
    String? positiveButtonText,
    Function()? positiveButtonAction,
    bool persistent = false,
  }) =>
      showDialog(
        context: context,
        barrierDismissible: !persistent,
        builder: (_) => CustomDialogView(
          title: title,
          description: description,
          header: header,
          positiveButtonText: positiveButtonText ?? (persistent ? null : Tr.popupButtonText()),
          positiveButtonAction: positiveButtonAction ?? (persistent ? null : () => goBack()),
          negativeButtonText: negativeButtonText,
          negativeButtonAction: negativeButtonAction ?? () => goBack(),
        ),
      );

  closeKeyboard() => FocusScope.of(context).unfocus();

  showToast(String message) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
}
