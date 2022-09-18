import '../models/hotel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum MyHotelEvents { addHotelInList, removeHotelFromList }

final myHotelListProvider =
    StateNotifierProvider<MyHotelList, List<HotelPreview>>(
        (_) => MyHotelList());

class MyHotelList extends StateNotifier<List<HotelPreview>> {
  MyHotelList() : super([]);

  void addHotelInList(HotelPreview hotel) {
    state = [...state, hotel];
  }

  void removeHotelFromList(HotelPreview hotel) {
    for (int i = 0; i < state.length; i++) {
      if (state[i].uuid == hotel.uuid) {
        state.removeAt(i);
        break;
      }
    }
  }
}
