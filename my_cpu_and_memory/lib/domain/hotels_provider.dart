import '../models/hotel.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final hotelsProvider = FutureProvider<List<HotelPreview>>((ref) async {
  String _hotelsURL =
      'https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301';
  final Dio _dio = Dio();

  try {
    final responce = await _dio.get(_hotelsURL);
    final hotels = responce.data
        .map<HotelPreview>((hotel) => HotelPreview.fromJson(hotel))
        .toList();
    return hotels;
  } on DioError catch (e) {
    return Future.error(e.toString());
  }
});
