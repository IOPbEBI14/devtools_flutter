import 'dart:async';

import 'package:devtools_flutter/domain/my_hotel_list_bloc.dart';
import 'package:devtools_flutter/models/my_hotels_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantity_input/quantity_input.dart';

import '../models/hotel.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet.dart';

class ListviewLayout extends StatefulWidget {
  final HotelPreview hotelInfo;
  final int tabIndex;
  final BuildContext blocContext;

  const ListviewLayout(
      {Key? key,
      required this.hotelInfo,
      required this.tabIndex,
      required this.blocContext})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListviewLayoutState();
}

class _ListviewLayoutState extends State<ListviewLayout> {
  @override
  Widget build(BuildContext context) {
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
                    'assets/images/${widget.hotelInfo.poster}',
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.hotelInfo.name,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        QuantityInput(
                          inputWidth: 30,
                          value: widget.hotelInfo.rating,
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
                            primary:
                                myHotelsList.containsKey(widget.hotelInfo.uuid)
                                    ? Colors.red
                                    : Colors.lightBlue,
                            // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            if (widget.tabIndex == 0 &&
                                !isBooked(widget.hotelInfo.uuid)) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) => toggleBottomSheet(
                                      widget.blocContext,
                                      MyHotelEvents.addHotelInList,
                                      widget.hotelInfo));
                            } else {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) => toggleBottomSheet(
                                      widget.blocContext,
                                      MyHotelEvents.removeHotelFromList,
                                      widget.hotelInfo));
                            }
                            setState(() {});
                          },
                          child: const Text(
                            'Я здесь был',
                            textAlign: TextAlign.justify,
                          ),
                        )
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
