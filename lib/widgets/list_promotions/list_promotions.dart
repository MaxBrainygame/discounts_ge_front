
import 'package:discounts_ge_front/domain/entity/shop.dart';
import 'package:flutter/material.dart';

class ListPromotions extends StatefulWidget {

  const ListPromotions({Key? key}) : super(key: key);

  @override
  _ListPromotionsState createState() => _ListPromotionsState();
}

class _ListPromotionsState extends State<ListPromotions> {

  late Shop shop;

  @override
  Widget build(BuildContext context) {
    RouteSettings? settings = ModalRoute.of(context)?.settings;
    shop = settings!.arguments as Shop;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotions'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(
              children: [
                Text(shop.name), 
              ],
            ),
            const Text('powered by Flutter\n')
          ],
        ),
      ),
    );
  }
}