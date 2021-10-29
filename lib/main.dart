import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Multi Cat Select"),
          ),
          body: Column(
            children: [
              const SizedBox(height: 50),
              CategoryFilter(),
              const Divider(
                height: 12,
                color: Colors.redAccent,
              ),
              SelectedCategories(),
            ],
          ),
        ));
  }
}

class SelectedCategories extends StatelessWidget {
  final Conttoller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Obx(
        () => ListView.builder(
          itemCount: controller.selecteCategories.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: CategoryWidget(
                category: controller.selecteCategories[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryFilter extends StatelessWidget {
  final controller = Get.put(Conttoller());

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Obx(
        () => ListView.builder(
          itemCount: controller.categories.length,
          itemBuilder: (_, index) {
            return CheckboxListTile(
              value: controller.selecteCategories
                  .contains(controller.categories[index]),
              onChanged: (bool? selected) {
                controller.toggle(controller.categories[index]);
              },
              title: CategoryWidget(
                category: controller.categories[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({
    Key? key,
    required this.category,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: category.color,
      ),
      child: Center(
        child: Text(
          category.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class Conttoller extends GetxController {
  var _categories = {
    Category(name: "Item 1", color: const Color(0xFFfe7743)): false,
    Category(name: "Item 2", color: const Color(0xFF21d0d0)): false,
    Category(name: "Item 5", color: const Color(0xFF895ed1)): false,
  }.obs;
  get categories => _categories.entries.map((e) => e.key).toList();
  get selecteCategories => _categories.entries
      .where(
        (element) => element.value,
      )
      .map((e) => e.key)
      .toList();
  void toggle(Category item) {
    _categories[item] = !(_categories[item] ?? true);
  }
}

class Category {
  final String name;
  final Color color;
  Category({
    required this.name,
    required this.color,
  });
}
