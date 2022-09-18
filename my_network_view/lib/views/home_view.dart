import 'dart:async';

import 'hotels_view.dart';
import 'my_hotels_listview.dart';

import 'package:flutter/material.dart';

class TabItem {
  String title;
  Icon icon;

  TabItem(this.title, this.icon);
}

final List<TabItem> _tabBar = [
  TabItem('Hotel List', const Icon(Icons.list_alt_outlined)),
  TabItem('My hotels', const Icon(Icons.home_outlined)),
];

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentTab = 0;

  void repaint(int index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabBar.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: SafeArea(
              child: TabBar(
                controller: _tabController,
                tabs: _tabBar.map((e) => Tab(text: e.title)).toList(),
                //   onTap: (index) => repaint(index),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            HotelsView(currentTab),
            MyHotelsListview(currentTab),
          ],
        ),
      ),
    );
  }
}
