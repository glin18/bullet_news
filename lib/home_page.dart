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
        body: const TabBarView(
          children: [
            Center(child: Text('Content for TODAY')),
            Center(child: Text('Content for POLITICS')),
            Center(child: Text('Content for ENTERTAINMENT')),
            Center(child: Text('Content for SPORTS')),
            Center(child: Text('Content for TECH')),
            Center(child: Text('Content for HEALTH')),
            Center(child: Text('Content for SCIENCE')),
            Center(child: Text('Content for BUSINESS')),
            Center(child: Text('Content for TRAVEL')),
          ],
        ),
      ),
    );
  }
}
