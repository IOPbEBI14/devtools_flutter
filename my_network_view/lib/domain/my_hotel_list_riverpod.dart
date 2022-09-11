import '../models/hotel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum MyHotelEvents { addHotelInList, removeHotelFromList }

final myHotelListProvider =
    StateNotifierProvider<MyHotelList, List<HotelPreview>>(
        (_) => MyHotelList());

class MyHotelList extends StateNotifier<List<HotelPreview>> {
  MyHotelList() : super([]);

  void addHotelInList(HotelPreview hotel) {
    List<HotelPreview> currentList = state;
    currentList.add(hotel);
    state = currentList;
  }

  void removeHotelFromList(HotelPreview hotel) {
    List<HotelPreview> currentList = state;
    for (int i = 0; i < currentList.length; i++) {
      if (currentList[i].uuid == hotel.uuid) {
        currentList.removeAt(i);
        break;
      }
    }
  }
}
