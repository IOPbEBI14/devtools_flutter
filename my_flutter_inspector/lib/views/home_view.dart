import 'dart:async';

import 'package:devtools_flutter/views/my_hotels_listview.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/hotel.dart';
import 'listview_layout.dart';

String _hotelsURL =
    'https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301';

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
  Future<List<HotelPreview>>? _hotels;
  final Dio _dio = Dio();
  late String _dioError;
  late TabController _tabController;
  int currentTab = 0;

  getData(String url) async {
    try {
      final responce = await _dio.get(url);
      _hotels = Future.value(responce.data
          .map<HotelPreview>((hotel) => HotelPreview.fromJson(hotel))
          .toList());
      setState(() {});
    } on DioError catch (e) {
      setState(() {
        _dioError = e.message;
        _hotels = Future.error(e.toString());
      });
    }
  }

  void repaint(int index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getData(_hotelsURL);
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
            color: Theme
                .of(context)
                .backgroundColor,
            child: SafeArea(
              child: TabBar(
                controller: _tabController,
                tabs: _tabBar.map((e) => Tab(text: e.title)).toList(),
                onTap: (index) => repaint(index),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            FutureBuilder(
                future: _hotels,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text(_dioError);
                      } else if (snapshot.hasData) {
                        return ListView.separated(
                            itemCount: snapshot.data.length,
                            separatorBuilder: (BuildContext context,
                                int index) =>
                            const Divider(
                              height: 2,
                              thickness: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return ListviewLayout(
                                hotelInfo: snapshot.data[index],
                                tabIndex: currentTab,
                              );
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    default:
                      return const Center(child: CircularProgressIndicator());
                  }
                }),
            MyHotelsListview(currentTab),
          ],
        ),
      ),
    );
  }
}
