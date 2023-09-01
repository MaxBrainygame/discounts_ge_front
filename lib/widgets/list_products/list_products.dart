import 'package:discounts_ge_front/domain/entity/promotion.dart';
import 'package:discounts_ge_front/widgets/bottom_bar_custom.dart';
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
      bottomNavigationBar: BottomBarWidget(),
      body: SafeArea(
        child: ListProductsModelProvider(
          model: model,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // _ReloadButton(),
              Expanded(
                child: Padding(
                  // padding: const EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            // childAspectRatio: 3 / 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 3.0),
        itemCount:
            ListProductsModelProvider.watch(context)?.model.products.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return _ProductsRowWidget(index: index);
        });
    // return ListView.builder(
    //   itemCount:
    //       ListProductsModelProvider.watch(context)?.model.products.length ?? 0,
    //   itemBuilder: (BuildContext context, int index) {
    //     return _ProductsRowWidget(index: index);
    //   },
    // );
  }
}

class _ProductsRowWidget extends StatelessWidget {
  final int index;
  const _ProductsRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product =
        ListProductsModelProvider.read(context)!.model.products[index];

    return Container(
      // padding: const EdgeInsets.all(10),
      // width: 174,
      // height: 250,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(
          18,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(child: getImage(product.picture)),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(product.title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                )),
            Row(
              children: [
                Text(   
                  product.finalPrice.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const Spacer(),
                Text(   
                  product.regularPrice.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough
                  ),
                ),
                
                
              ],
            )
          ],
        ),
      ),
    );
  }

  // return Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: <Widget>[
  //     GestureDetector(
  //       onTap: () {
  //         // Navigator.pushNamed(context, '/promotions', arguments: shop);
  //       },
  //       child: getImage(product.picture),
  //     ),
  //     // Text(shop.host),
  //     // const SizedBox(height: 10),
  //     // getImage(shop.logo),
  //     // const SizedBox(height: 10),
  //     // Text(shop.name),
  //     const SizedBox(height: 40),
  //   ],
  // );
}

Widget getImage(srcLogo) {
  if (srcLogo.endsWith('svg')) {
    return SvgPicture.network(srcLogo);
  } else {
    return Image.network(srcLogo);
  }
}
