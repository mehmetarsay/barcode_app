import 'package:barcode_app/locator.dart';
import 'package:barcode_app/resources/strings/asset_map.dart';

enum Tr {
  popupButtonText,
  productsTitle,
  selectedProductsEmptyText,
  price,
  stock,
  products,
  selectedProducts,
  productDeleted,
  productAdded,
  ;

  const Tr();

  static String? fromKey(String? key) => sl<AssetMap>()[key];

  String get key => name;

  String call() => fromKey(key) ?? '';

  bool isA(String? value) => key == value;

  int getInt() => int.tryParse(call()) ?? 0;

  double getDouble() => double.tryParse(call()) ?? 0.0;

  bool getBool() {
    final value = call().toLowerCase();
    return value == '1' || value == 'true';
  }
}

extension TrListExtensions on Iterable<Tr> {
  bool has(String? key) => map((tr) => tr.key).contains(key);
}
