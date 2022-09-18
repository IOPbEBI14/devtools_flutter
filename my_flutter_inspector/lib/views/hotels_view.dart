import 'package:devtools_flutter/domain/hotels_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'listview_layout.dart';

class HotelsView extends HookConsumerWidget {
  const HotelsView(this.currentTab, {Key? key}) : super(key: key);
  final int currentTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hotels = ref.watch(hotelsProvider);

    return hotels.when(
        error: (err, stack) => Center(child: Text(err.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (hotels) => ListView.separated(
            itemCount: hotels.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  height: 2,
                  thickness: 1,
                ),
            itemBuilder: (BuildContext context, int index) {
              return ListviewLayout(
                hotelInfo: hotels[index],
                tabIndex: currentTab,
              );
            }));
  }
}
