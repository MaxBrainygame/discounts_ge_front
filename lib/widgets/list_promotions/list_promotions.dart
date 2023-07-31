
import 'package:discounts_ge_front/domain/entity/shop.dart';
import 'package:discounts_ge_front/widgets/list_promotions/list_promotions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListPromotions extends StatefulWidget {

  const ListPromotions({Key? key}) : super(key: key);

  @override
  _ListPromotionsState createState() => _ListPromotionsState();
}

class _ListPromotionsState extends State<ListPromotions> {
  final model = ListPromotionModel();
  late Shop shop;

  @override
  Widget build(BuildContext context) {
    RouteSettings? settings = ModalRoute.of(context)?.settings;
    shop = settings!.arguments as Shop;
    model.reloadPromotions(shop.host);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotions'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListPromotionModelProvider(
          model: model,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // _ReloadButton(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _PromotionsWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromotionsWidget extends StatelessWidget {
  const _PromotionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ListPromotionModelProvider.watch(context)?.model.promotions.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _PromotionsRowWidget(index: index);
      },
    );
  }
}

class _PromotionsRowWidget extends StatelessWidget {
  final int index;
  const _PromotionsRowWidget({Key? key, required this.index}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final promotion = ListPromotionModelProvider.read(context)!.model.promotions[index];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/goods', arguments: promotion);
          },
          child: getImage(promotion.picture),
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