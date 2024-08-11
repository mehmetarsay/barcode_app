import 'package:barcode_app/locator.dart';
import 'package:barcode_app/network/api.dart';
import 'package:barcode_app/network/models/product_model.dart';
import 'package:barcode_app/network/network_manager.dart';
import 'package:barcode_app/resources/strings/tr.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

const limit = 20;

@lazySingleton
class ProductService with ListenableServiceMixin {
  final NetworkManager _networkManager;

  ProductService(this._networkManager) {
    listenToReactiveValues([_products, _selectProduct]);
  }

  final _products = ReactiveList<Product>();
  final _selectProduct = ReactiveList<Product>();

  List<Product> get products => _products.toList(growable: false);
  List<Product> get selectProduct => _selectProduct.toList(growable: false);

  int get skip => _products.length;

  Future<List<Product>?> getProducts({bool isFetch = false}) async {
    final res = await _networkManager.get('products?limit=$limit&skip=${isFetch ? skip : 0}').req();
    final data = res['products'] as List;
    final products = data.map((e) => Product.fromJson(e)).toList();
    isFetch ? _products.addAll(products) : _products.assignAll(products);
    return products;
  }

  Future<Product?> getProduct(String id) async {
    try {
      final res = await _networkManager.get('products/$id').req();
      if (res == null) return null;
      return Product.fromJson(res);
    } catch (e) {
      if (e is ApiError && e.message == 'Not Found') return null;
      rethrow;
    }
  }

  addProduct({Product? product, String? barcode}) async {
    if (product != null) return _selectProductAdd(product);
    if (barcode != null) {
      final index = _products.indexWhere((element) => element.meta.barcode == barcode);
      if (index != -1) return _selectProductAdd(_products[index]);
    }
    final productData = await getProduct(barcode!);
    if (productData == null) throw '"$barcode"\nProduct not found';
    _selectProductAdd(productData);
  }

  selectProductRemove(Product product) {
    if (!_selectProduct.contains(product)) throw 'Product not found';
    _selectProduct.remove(product);
    navigator.showToast('${product.title} ${Tr.productDeleted()}');
  }

  _selectProductAdd(Product product) {
    if (_selectProduct.contains(product)) throw 'Product already added';
    _selectProduct.add(product);
     navigator.showToast('${product.title} ${Tr.productAdded()}');
  }
}
