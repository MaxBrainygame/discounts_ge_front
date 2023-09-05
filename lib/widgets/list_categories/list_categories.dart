import 'package:discounts_ge_front/generated/l10n.dart';
import 'package:discounts_ge_front/widgets/app/locale_provider.dart';
import 'package:discounts_ge_front/widgets/app/my_app.dart';
import 'package:discounts_ge_front/widgets/bottom_bar_custom.dart';
import 'package:discounts_ge_front/widgets/list_categories/list_categories_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({Key? key}) : super(key: key);

  @override
  _ListCategoriesState createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  final model = ListCategoriesModel();

  @override
  void initState() {
    super.initState();
    model.reloadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).categories),
        centerTitle: true,
        actions: [
          Consumer<LocaleProvider>(
            builder: (context, localeModel, child) => 
              Padding(padding: EdgeInsets.all(10), child: PopupMenuButton<Locale>(
              onSelected: (value) {
                setState(() {
                  S.delegate.load(value);
                  localeModel.setLocale(value);
                });
              },
              itemBuilder: (BuildContext context) {
                return S.delegate.supportedLocales.map((Locale choice) {
                  return PopupMenuItem<Locale>(
                    value: choice,
                    child: Text(choice.toLanguageTag()),
                  );
                }).toList();
              },
              child: Icon(Icons.language),
            )
          ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(),
      body: ListCategoriesModelProvider(
        model: model,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _CategoriesWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoriesWidget extends StatelessWidget {
  const _CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: ListCategoriesModelProvider.watch(context)
                    ?.model
                    .categories
                    .length ??
                0,
            itemBuilder: (BuildContext context, int index) {
              return _CategoriesRowWidget(index: index);
            },
          ),
        ],
      ),
    );
    // return GridView.builder(
    //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //         maxCrossAxisExtent: 200,
    //         // childAspectRatio: 3 / 2,
    //         crossAxisSpacing: 4.0,
    //         mainAxisSpacing: 3.0),
    //     itemCount: ListCategoriesModelProvider.watch(context)
    //             ?.model
    //             .categories
    //             .length ??
    //         0,
    //     itemBuilder: (BuildContext context, int index) {
    //       return _CategoriesRowWidget(index: index);
    //     });
  }
}

class _CategoriesRowWidget extends StatelessWidget {
  final int index;
  const _CategoriesRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category =
        ListCategoriesModelProvider.read(context)!.model.categories[index];
    double screenHeight = MediaQuery.of(context).size.height;
    // return Container(
    //   alignment: Alignment.center,
    //   decoration: BoxDecoration(
    //     border: Border.all(color: Colors.black),
    //     borderRadius: BorderRadius.circular(15)),
    //   child: IconButton(
    //     onPressed: () {
    //       Navigator.pushNamed(context, '/shops', arguments: category);
    //     },
    //     icon: Icon(IconData(category.key, fontFamily: 'MaterialIcons'))
    //     )
    // );
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/shops', arguments: category);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(18),
        ),
        height: screenHeight / 15,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Icon(IconData(category.key, fontFamily: 'MaterialIcons')),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              category.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const Expanded(child: SizedBox()),
            const Icon(Icons.arrow_forward_ios_sharp)
          ],
        ),
      ),
    );
  }
}
