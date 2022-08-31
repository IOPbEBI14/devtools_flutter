import 'package:devtools_flutter/models/hotel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/my_hotel_list_riverpod.dart';

Widget toggleBottomSheet(BuildContext context, WidgetRef ref,
    MyHotelEvents event, HotelPreview hotel) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ListTile(
        title: const Text('Accept'),
        leading: const Icon(Icons.person),
        onTap: () {
          if (event == MyHotelEvents.addHotelInList) {
            ref
                .read<MyHotelList>(myHotelListProvider.notifier)
                .addHotelInList(hotel);
          } else {
            ref
                .read<MyHotelList>(myHotelListProvider.notifier)
                .removeHotelFromList(hotel);
          }
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}