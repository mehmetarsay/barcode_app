import 'package:barcode_app/extensions/string_extension.dart';
import 'package:barcode_app/locator.dart';
import 'package:barcode_app/resources/d_text_styles.dart';
import 'package:barcode_app/resources/strings/tr.dart';
import 'package:barcode_app/view/products/products_view.dart';
import 'package:barcode_app/widget/close_button.dart';
import 'package:flutter/material.dart';

enum Routes<P> {
  products(ProductsView.new,wrap: false),
  ;

  final bool wrap;
  final Tr? title;
  final Leading? leading;
  final Widget Function(P) _wb;

  AppBar? get appBar => title != null || leading != null
      ? AppBar(
          leading: leading?.wb.call(),
          title: title != null ? Text(title!(), style: DTextStyles.title) : null,
        )
      : null;

  const Routes(this._wb, {this.leading, this.title, this.wrap = true});

  Widget viewBuilder(String? p) => _wb(_unmap(p));

  Future<T?>? call<T>({P? data, bool replace = false, bool clearStack = false}) =>
      toUri(data: data).go(replace: replace, clearStack: clearStack);

  void returnBack() => navigator.goBackUntil(this);

  Uri toUri({P? data}) => Uri(path: name, queryParameters: data != null ? {'q': _map(data)} : null);
}

String _map(value) {
  if (value is Enum) return value.name;
  return value.toString();
}

T _unmap<T>(String? param) {
  if (T == int) return int.tryParse(param!)! as T;
  if (T == bool) return param?.parseBool() as T;
  return param as T;
}

extension UriRouteExtensions on Uri {
  bool contains(Routes route, [arg]) {
    if (path != route.name) return false;
    if (arg == null) return true;
    return queryParameters.values.contains(_map(arg));
  }

  Routes get route => Routes.values.byName(path);

  Future<T?>? go<T>({bool replace = false, bool clearStack = false}) =>
      navigator.navigateTo(this, replace: replace, clearStack: clearStack);
}
