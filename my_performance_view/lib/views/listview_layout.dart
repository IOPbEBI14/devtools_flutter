import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quantity_input/quantity_input.dart';

import '../domain/my_hotel_list_riverpod.dart';
import '../models/hotel.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet.dart';

class ListviewLayout extends ConsumerWidget {
  final HotelPreview hotelInfo;
  final int tabIndex;

  const ListviewLayout(
      {Key? key, required this.hotelInfo, required this.tabIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var myHotelsList = ref.watch(myHotelListProvider);
    return SizedBox(
      height: 200,
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(45)),
            child: Row(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/${hotelInfo.poster}',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          hotelInfo.name,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        QuantityInput(
                          inputWidth: 30,
                          value: hotelInfo.rating,
                          onChanged: (hotelRating) => null,
                          // provider.editHotel(_hotelList[index]
                          //     .copyWith(
                          //     rating: int.parse(
                          //         hotelRating.replaceAll(
                          //             ',', '')))),
                          maxValue: 10,
                        ),
                        TextButton(
                          style: ElevatedButton.styleFrom(
                            primary: myHotelsList.containsKey(hotelInfo.uuid)
                                ? Colors.red
                                : Colors.lightBlue,
                            // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            if (tabIndex == 0 &&
                                !myHotelsList.containsKey(hotelInfo.uuid)) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) => toggleBottomSheet(
                                      context,
                                      ref,
                                      MyHotelEvents.addHotelInList,
                                      hotelInfo));
                            } else {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) => toggleBottomSheet(
                                      context,
                                      ref,
                                      MyHotelEvents.removeHotelFromList,
                                      hotelInfo));
                            }
                          },
                          child: const Text(
                            'Я здесь был',
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}