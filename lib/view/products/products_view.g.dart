// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_view.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class ProductsView extends StatelessWidget {
  const ProductsView(
    this.data, {
    Key? key,
  }) : super(key: key);

  final void data;

  @override
  Widget build(BuildContext _context) => productsView(
        _context,
        data,
      );
}

class _Title extends StatelessWidget {
  const _Title(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext _context) => __title(title);
}

class BuildSelectProductPanel extends StatelessWidget {
  const BuildSelectProductPanel({
    Key? key,
    required this.product,
    required this.onDeleted,
  }) : super(key: key);

  final Product product;

  final dynamic Function() onDeleted;

  @override
  Widget build(BuildContext _context) => _buildSelectProductPanel(
        product: product,
        onDeleted: onDeleted,
      );
}

class BuildProductPanel extends StatelessWidget {
  const BuildProductPanel({
    Key? key,
    required this.product,
    required this.index,
    this.isExpanded = false,
    required this.expansionCallback,
    this.addProduct,
  }) : super(key: key);

  final Product product;

  final int index;

  final bool isExpanded;

  final dynamic Function(int?) expansionCallback;

  final dynamic Function()? addProduct;

  @override
  Widget build(BuildContext _context) => _buildProductPanel(
        product: product,
        index: index,
        isExpanded: isExpanded,
        expansionCallback: expansionCallback,
        addProduct: addProduct,
      );
}
