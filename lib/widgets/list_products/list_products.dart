import 'package:discounts_ge_front/domain/entity/promotion.dart';
import 'package:discounts_ge_front/widgets/list_products/list_products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListProducts extends StatefulWidget {

  const ListProducts({Key? key}) : super(key: key);

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  final model = ListProductsModel();
  late Promotion promotion;

  @override
  Widget build(BuildContext context) {
    RouteSettings? settings = ModalRoute.of(context)?.settings;
    promotion = settings!.arguments as Promotion;
    model.reloadProducts(promotion);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListProductsModelProvider(
          model: model,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // _ReloadButton(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _ProductsWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductsWidget extends StatelessWidget {
  const _ProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ListProductsModelProvider.watch(context)?.model.products.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _ProductsRowWidget(index: index);
      },
    );
  }
}

class _ProductsRowWidget extends StatelessWidget {
  final int index;
  const _ProductsRowWidget({Key? key, required this.index}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final product = ListProductsModelProvider.read(context)!.model.products[index];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, '/promotions', arguments: shop);
          },
          child: getImage(product.picture),
        ),
        // Text(shop.host),
        // const SizedBox(height: 10),
        // getImage(shop.logo),
        // const SizedBox(height: 10),
        // Text(shop.name),
        const SizedBox(height: 40),
      ],
    );
  }
}

Widget getImage(srcLogo) {

  if (srcLogo.endsWith('svg')) {
      return SvgPicture.network(srcLogo);  
  } else {
      return Image.network(srcLogo);
    } 

}