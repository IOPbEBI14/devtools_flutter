import 'package:devtools_flutter/domain/my_hotel_list_bloc.dart';
import 'package:devtools_flutter/models/hotel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget toggleBottomSheet(
    BuildContext context, MyHotelEvents event, HotelPreview hotel) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ListTile(
        title: const Text('Accept'),
        leading: const Icon(Icons.person),
        onTap: () {
          if (event == MyHotelEvents.addHotelInList) {
            context.read<MyHotelListBloc>().addHotelInList(hotel);
          } else {
            context.read<MyHotelListBloc>().removeHotelFromList(hotel);
          }
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
