import 'package:bullet_news/models/category.dart';
import 'package:bullet_news/services/category_service.dart';
import 'package:bullet_news/views/saved_news_page.dart';
import 'package:bullet_news/widgets/news_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Category>> _categoriesFuture;
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService().fetchNews();
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint("Error signing out: $e");
    }
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
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(171, 155, 39, 176),
                      ),
                      child: Text(
                        userEmail.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.bookmark),
                      title: const Text('Saved News'),
                      onTap: () {
                        Navigator.of(context).pop(); // Close the drawer
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SavedNewsPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Logout'),
                      onTap: _logout,
                    ),
                  ],
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
