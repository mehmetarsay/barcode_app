import 'package:barcode_app/network/models/product_model.dart';
import 'package:barcode_app/services/product_service.dart';
import 'package:barcode_app/util/barcode_scanner.dart';
import 'package:barcode_app/util/pagination_controller.dart';
import 'package:barcode_app/widget/view_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProductsViewModel extends PaginationScrollController {
  final ProductService _productService;

  ProductsViewModel(this._productService);

  List<Product> get allProducts => _productService.products;
  List<Product> get selectProducts => _productService.selectProduct;

  ValueNotifier<int?> expandedIndex = ValueNotifier<int?>(null);

  init() => request(() => Future.wait([
        _productService.getProducts(),
      ]));

  Future<List<Product>?> fetchProducts() async => await _productService.getProducts(isFetch: true);

  @override
  Future<bool> fetchData() async {
    final data = await fetchProducts();
    return data?.isNotEmpty ?? false;
  }

  @override
  void dispose() {
    expandedIndex.dispose();
    super.dispose();
  }

  addProduct({Product? product, String? barcode}) =>
      request(() => _productService.addProduct(product: product, barcode: barcode));

  deleteProduct(Product product) => _productService.selectProductRemove(product);

  barcodeScan() async => request(()async{
      var barcode = await BarcodeScannerWrapper.customScanFunction();
    if (barcode == null) return;
    addProduct(barcode: barcode);
});

  @override
  List<ListenableServiceMixin> get listenableServices => [_productService];
}
