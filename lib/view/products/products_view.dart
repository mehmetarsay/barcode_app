import 'package:barcode_app/locator.dart';
import 'package:barcode_app/network/models/product_model.dart';
import 'package:barcode_app/resources/d_colors.dart';
import 'package:barcode_app/resources/d_text_styles.dart';
import 'package:barcode_app/resources/dimens.dart';
import 'package:barcode_app/resources/strings/tr.dart';
import 'package:barcode_app/view/products/products_view_model.dart';
import 'package:barcode_app/widget/view_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:stacked/stacked.dart';
part 'products_view.g.dart';

@swidget
Widget productsView(BuildContext context, void data) => ViewModelBuilder<ProductsViewModel>.reactive(
      viewModelBuilder: () => ProductsViewModel(sl()),
      onViewModelReady: (model) => model.init(),
      builder: (_, model, __) => Scaffold(
        appBar: AppBar(title: Text(Tr.productsTitle(), style: DTextStyles.title)),
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.barcodeScan(),
          child: const Icon(Icons.barcode_reader),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            model.loadMore(notification);
            return true;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DDimens.l),
            child: CustomScrollView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _Title(Tr.selectedProducts())),
                model.selectProducts.isNotEmpty
                    ? SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 110,
                              child: Card(
                                color: DColors.secondary,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.selectProducts.length,
                                  itemBuilder: (context, i) => BuildSelectProductPanel(
                                      product: model.selectProducts[i],
                                      onDeleted: () => model.deleteProduct(model.selectProducts[i])),
                                ),
                              ),
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(Icons.info_outline, color: Colors.grey,size: 15,),
                                const SizedBox(width: DDimens.xs),
                                Text(Tr.productDeleteInfo(), style: DTextStyles.greySmallLight),
                                const SizedBox(width: DDimens.xs),
                              ],
                            ),
                          ],
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Align(
                        alignment: Alignment.center,
                        child: Text(Tr.selectedProductsEmptyText()),
                      )),
                const SliverToBoxAdapter(child: SizedBox(height: DDimens.m)),
                SliverToBoxAdapter(child: _Title(Tr.products())),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => ValueListenableBuilder<int?>(
                        valueListenable: model.expandedIndex,
                        builder: (_, value, ___) => BuildProductPanel(
                              product: model.allProducts[i],
                              index: i,
                              isExpanded: value == i,
                              expansionCallback: (index) => model.expandedIndex.value = index,
                              addProduct: () => model.addProduct(product: model.allProducts[i]),
                            )),
                    childCount: model.allProducts.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ValueListener(
                    listenable: model.isLoading,
                    builder: (bool value) => value ? const CenterLoading() : const SizedBox(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

@swidget
Widget __title(String title) => Column(
      children: [
        Align(alignment: Alignment.centerLeft, child: Text(title, style: DTextStyles.darkBold)),
        const Divider()
      ],
    );

@swidget
Widget _buildSelectProductPanel({required Product product, required Function() onDeleted}) => Dismissible(
      key: Key(product.meta.barcode.toString()),
      direction: DismissDirection.up,
      onDismissed: (direction) => onDeleted(),
      background: Container(color: Colors.red),
      child: Card(
        child: Column(
          children: [
            Hero(
              tag: product.id,
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                width: 60,
                height: 60,
                placeholder: (_, __) => const Icon(Icons.image),
                errorWidget: (_, __, ___) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(DDimens.s),
              child: Text('\$${product.price}', style: const TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );

@swidget
Widget _buildProductPanel({
  required Product product,
  required int index,
  bool isExpanded = false,
  required Function(int? panelIndex) expansionCallback,
  Function()? addProduct,
}) =>
    Card(
      child: ExpansionPanelList(
        expansionCallback: (int panelIndex, bool isExpandedVal) => expansionCallback(isExpandedVal ? index : null),
        children: [
          ExpansionPanel(
            isExpanded: isExpanded,
            headerBuilder: (context, isExpanded) => ListTile(
              leading: Hero(
                tag: product.id,
                child: CachedNetworkImage(
                  imageUrl: product.thumbnail,
                  width: 60,
                  height: 60,
                  placeholder: (_, __) => const Icon(Icons.image),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                ),
              ),
              title: Text(product.title, style: DTextStyles.darkRegularText),
              subtitle: Text(product.brand ?? '', style: DTextStyles.greyRegular),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DDimens.m, vertical: DDimens.s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${Tr.price()} \$${product.price}', style: DTextStyles.greyMedium),
                  Text(
                    '${Tr.stock()} ${product.stock}',
                    style: DTextStyles.greyMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    product.description,
                    style: const TextStyle(color: Colors.black54),
                    maxLines: isExpanded ? null : 2,
                    overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: DDimens.s),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_shipping, color: Colors.grey[600]),
                          const SizedBox(width: DDimens.xs),
                          Text(product.shippingInformation, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      if (addProduct != null)
                        IconButton(
                            onPressed: addProduct,
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              color: DColors.secondary,
                            ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
