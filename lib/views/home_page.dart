import 'package:bullet_news/models/category.dart';
import 'package:bullet_news/services/category_service.dart';
import 'package:bullet_news/widgets/news_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text("Error: ${snapshot.error}")));
        } else if (snapshot.hasData) {
          final categories = snapshot.data!;
          return DefaultTabController(
            length: categories.length,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Bullet News"),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: categories
                      .map((category) => Tab(text: category.name.toUpperCase()))
                      .toList(),
                ),
              ),
              body: TabBarView(
                children: categories
                    .map((category) =>
                        NewsList(category: category.name, id: category.id))
                    .toList(),
              ),
            ),
          );
        } else {
          return const Scaffold(body: Center(child: Text("No data")));
        }
      },
    );
  }
}
