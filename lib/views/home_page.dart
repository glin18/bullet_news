import 'package:bullet_news/widgets/news_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Bullet News"),
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'TODAY'),
                Tab(text: 'POLITICS'),
                Tab(text: 'ENTERTAINMENT'),
                Tab(text: 'SPORTS'),
                Tab(text: 'TECH'),
                Tab(text: 'HEALTH'),
                Tab(text: 'SCIENCE'),
                Tab(text: 'BUSINESS'),
                Tab(text: 'TRAVEL'),
              ],
            )),
        body: TabBarView(
          children: [
            NewsList(category: "TODAY"),
            NewsList(category: "POLITICS"),
            NewsList(category: "ENTERTAINMENT"),
            NewsList(category: "SPORTS"),
            NewsList(category: "TECH"),
            NewsList(category: "HEALTH"),
            NewsList(category: "SCIENCE"),
            NewsList(category: "BUSINESS"),
            NewsList(category: "TRAVEL"),
          ],
        ),
      ),
    );
  }
}
