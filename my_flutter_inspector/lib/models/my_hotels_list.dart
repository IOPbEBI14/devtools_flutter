import 'package:devtools_flutter/models/hotel.dart';

Map<String, HotelPreview> myHotelsList = {};

void addHotelInList(HotelPreview hotel) {
  myHotelsList.putIfAbsent(hotel.uuid, () => hotel);
}

void removeHotelFromList(String uid) {
  myHotelsList.remove(uid);
}

bool isBooked(String uid) {
  return myHotelsList.containsKey(uid);
}
