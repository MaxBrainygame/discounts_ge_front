// import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:discounts_ge_front/domain/entity/product.dart';
import 'package:discounts_ge_front/domain/entity/promotion.dart';
import 'package:discounts_ge_front/generated/l10n.dart';
import 'package:discounts_ge_front/widgets/bottom_bar_custom.dart';
import 'package:discounts_ge_front/widgets/list_products/list_products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ListProducts extends StatefulWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  final model = ListProductsModel();
  late Promotion promotion;
  // bool _isLoading = true;
  // late PDFDocument? pdfDocument;

  // @override
  // void initState() {
  //   super.initState();
  //   loadDocument();
  // }

  // Future<void> loadDocument() async {
  //   pdfDocument = await PDFDocument.fromURL('http://nikorasupermarket.ge/modules/catalogues/uploads/42.pdf');
  //   setState(() => _isLoading = false);
  // }

  @override
  Widget build(BuildContext context) {
    RouteSettings? settings = ModalRoute.of(context)?.settings;
    promotion = settings!.arguments as Promotion;
    model.reloadProducts(promotion);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).products),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomBarWidget(),
      // body: Center(
      //     child: _isLoading
      //         ? Center(child: CircularProgressIndicator())
      //         : pdfDocument != null ? PDFViewer(document: pdfDocument!): Text('No document available'))
      body: SafeArea(
        child: ListProductsModelProvider(
          model: model,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // _ReloadButton(),
              Expanded(
                child: Padding(
                  // padding: const EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: _ProductsWidget(),
                ),
              )
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
    final products = ListProductsModelProvider.read(context)?.model.products;
    if (products?.length == 1 && products?[0].picture == "") {
      return SfPdfViewer.network(
          ListProductsModelProvider.read(context)!.model.products[0].url,
          scrollDirection: PdfScrollDirection.horizontal,
          pageLayoutMode: PdfPageLayoutMode.single);
    } else {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              // childAspectRatio: 3 / 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 3.0),
          itemCount:
              ListProductsModelProvider.watch(context)?.model.products.length ??
                  0,
          itemBuilder: (BuildContext context, int index) {
            return _ProductsRowWidget(index: index);
          });
    }
  }
}

class _ProductsRowWidget extends StatelessWidget {
  final int index;
  const _ProductsRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product =
        ListProductsModelProvider.read(context)!.model.products[index];

    // return SfPdfViewer.network(product.url);

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
                      decoration: TextDecoration.lineThrough),
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
