import 'package:devtools_flutter/models/my_hotels_list.dart' as mhl;

import '../models/hotel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MyHotelEvents { addHotelInList, removeHotelFromList }

abstract class MyHotel {}

class AddHotelInList extends MyHotel {
  late HotelPreview hotel;

  AddHotelInList(this.hotel);
}

class RemoveHotelFromList extends MyHotel {
  late HotelPreview hotel;

  RemoveHotelFromList(this.hotel);
}

class MyHotelListBloc extends Cubit<Map<String, HotelPreview>> {
  MyHotelListBloc() : super({});

  void addHotelInList(HotelPreview hotel) {
    mhl.addHotelInList(hotel);
    Map<String, HotelPreview> newHotelList = mhl.myHotelsList;
    emit(newHotelList);
  }

  void removeHotelFromList(HotelPreview hotel) {
    mhl.removeHotelFromList(hotel.uuid);
    Map<String, HotelPreview> newHotelList = mhl.myHotelsList;
    emit(newHotelList);
  }
}
