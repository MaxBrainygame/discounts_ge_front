import 'package:discounts_ge_front/widgets/list_categories/list_categories_model.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Categories'),
        centerTitle: true,
      ),
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
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount:
            ListCategoriesModelProvider.watch(context)?.model.categories.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return _CategoriesRowWidget(index: index);
        });
  }
}

class _CategoriesRowWidget extends StatelessWidget {
  final int index;
  const _CategoriesRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = ListCategoriesModelProvider.read(context)!.model.categories[index];

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15)),
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/shops', arguments: category);
        },
        icon: Icon(IconData(category.key, fontFamily: 'MaterialIcons'))
        )
    );
  }
}
