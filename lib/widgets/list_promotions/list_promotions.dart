import 'package:discounts_ge_front/domain/entity/shop.dart';
import 'package:discounts_ge_front/generated/l10n.dart';
import 'package:discounts_ge_front/widgets/bottom_bar_custom.dart';
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
        title: Text(S.of(context).promotions),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomBarWidget(),
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
      itemCount:
          ListPromotionModelProvider.watch(context)?.model.promotions.length ??
              0,
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
    final promotion =
        ListPromotionModelProvider.read(context)!.model.promotions[index];
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/goods', arguments: promotion);
      },
      child: Padding(padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(    
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(18),
        ),
        height: screenHeight / 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
          //  const SizedBox(width: 5, height: 5),
           getImage(promotion.picture, screenHeight),
            // Padding(
            //         padding: const EdgeInsets.all(2),
            //         child: getImage(promotion.picture, screenHeight)),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  promotion.title,
                  // maxLines: 3,
                  // overflow: TextOverflow,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    // color: HomeCubit.get(context).isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
    )
    );
  }
}

Widget getImage(srcLogo, double screenHeight) {
  if (srcLogo.endsWith('svg')) {
    return SvgPicture.network(srcLogo);
  } else {
    return Image.network(srcLogo, fit: BoxFit.cover, width: screenHeight / 4.5, height: screenHeight / 5,);
  }
}
