import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable(explicitToJson: true)
class HotelPreview {

  final String uuid;
  final String name;
  final String poster;
  @JsonKey(defaultValue: false)
  final bool booked;
  @JsonKey(defaultValue: 5)
  final int rating;

  HotelPreview(
      {required this.uuid,
        required this.name,
        required this.poster,
        required this.booked,
        required this.rating});

  factory HotelPreview.fromJson(Map<String, dynamic> json) =>
      _$HotelPreviewFromJson(json);
  Map<String, dynamic> toJson() => _$HotelPreviewToJson(this);
}
