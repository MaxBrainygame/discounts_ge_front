import 'package:discounts_ge_front/widgets/list_shops/list_shops_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListShops extends StatefulWidget {
  const ListShops({Key? key}) : super(key: key);

  @override
  _ListShopsState createState() => _ListShopsState();
}

class _ListShopsState extends State<ListShops> {
  final model = ListShopsModel();

  @override
  void initState() {
    super.initState();
    model.reloadShops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shops'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListShopsModelProvider(
          model: model,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // _ReloadButton(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _ShopsWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _ReloadButton extends StatelessWidget {
//   const _ReloadButton({Key? key}) : super(key: key);
// 
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () => ListShopsModelProvider.read(context)?.model.reloadShops(),
//       child: const Text('Обновить магазины'),
//     );
//   }
// }

class _ShopsWidget extends StatelessWidget {
  const _ShopsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ListShopsModelProvider.watch(context)?.model.shops.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _ShopsRowWidget(index: index);
      },
    );
  }
}

class _ShopsRowWidget extends StatelessWidget {
  final int index;
  const _ShopsRowWidget({Key? key, required this.index}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final shop = ListShopsModelProvider.read(context)!.model.shops[index];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/promotions', arguments: shop);
          },
          child: getImage(shop.logo),
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