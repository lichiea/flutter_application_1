import 'package:json_annotation/json_annotation.dart';

part 'content.g.dart';

@JsonSerializable()
class Coord {
  final double? lon;
  final double? lat;

  Coord({
    this.lon, 
    this.lat
  });
  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
  
  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class MainData {
  final int? aqi;

  MainData({
    this.aqi,
  });

  factory MainData.fromJson(Map<String, dynamic> json) => 
      _$MainDataFromJson(json);
  
  Map<String, dynamic> toJson() => _$MainDataToJson(this);
}

@JsonSerializable()
class Components {
  final double? co;    // Угарный газ, μg/m³
  final double? no;    // Оксид азота, μg/m³
  final double? no2;   // Диоксид азота, μg/m³
  final double? o3;    // Озон, μg/m³
  final double? so2;   // Диоксид серы, μg/m³
  final double? pm25;  // Частицы PM2.5, μg/m³
  final double? pm10;  // Частицы PM10, μg/m³
  final double? nh3;   // Аммиак, μg/m³

  Components({
    this.co,
    this.no,
    this.no2,
    this.o3,
    this.so2,
    this.pm25,
    this.pm10,
    this.nh3,
  });

  factory Components.fromJson(Map<String, dynamic> json) => 
      _$ComponentsFromJson(json);
  
  Map<String, dynamic> toJson() => _$ComponentsToJson(this);
}

@JsonSerializable()
class PollutionData {
  final int? dt;
  final MainData? main;
  final Components? components;

  PollutionData({
    this.dt,
    this.main,
    this.components,
  });

  factory PollutionData.fromJson(Map<String, dynamic> json) => 
      _$PollutionDataFromJson(json);
  
  Map<String, dynamic> toJson() => _$PollutionDataToJson(this);
}

@JsonSerializable()
class Content {
  final Coord? coord;
  final List<PollutionData>? list;

  Content({
    this.coord,
    this.list,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
