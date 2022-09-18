import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../domain/my_hotel_list_riverpod.dart';
import 'package:flutter/material.dart';

import 'listview_layout.dart';

class MyHotelsListview extends HookConsumerWidget {
  final int currentTab;

  const MyHotelsListview(this.currentTab, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myHotelsList = ref.watch(myHotelListProvider);
    if (myHotelsList.isNotEmpty) {
      return ListView.separated(
          itemCount: myHotelsList.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 2,
                thickness: 1,
              ),
          itemBuilder: (BuildContext itemBuilderContext, int index) {
            return ListviewLayout(
              hotelInfo: myHotelsList[index],
              tabIndex: currentTab,
            );
          });
    } else {
      return const Center(
        child: Text(
          'Лучше гор могут быть только горы, на которых еще не бывал. Съезди куда-нибудь и возвращайся',
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      );
    }
  }
}
