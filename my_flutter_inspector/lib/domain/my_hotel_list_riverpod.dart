import 'package:devtools_flutter/models/hotel.dart';
import 'package:riverpod/riverpod.dart';

enum MyHotelEvents {addHotelInList, removeHotelFromList}

final myHotelListProvider =
    StateNotifierProvider<MyHotelList, Map<String, HotelPreview>>(
        (_) => MyHotelList());

class MyHotelList extends StateNotifier<Map<String, HotelPreview>> {
  MyHotelList() : super({});

  void addHotelInList(HotelPreview hotel) {
    Map<String, HotelPreview> currentList = state;
    currentList.putIfAbsent(hotel.uuid, () => hotel);
    state=currentList;
  }

  void removeHotelFromList(HotelPreview hotel) {
    state.remove(hotel.uuid);
  }
}
