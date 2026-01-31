// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coord _$CoordFromJson(Map<String, dynamic> json) => Coord(
  lon: (json['lon'] as num?)?.toDouble(),
  lat: (json['lat'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
  'lon': instance.lon,
  'lat': instance.lat,
};

MainData _$MainDataFromJson(Map<String, dynamic> json) =>
    MainData(aqi: (json['aqi'] as num?)?.toInt());

Map<String, dynamic> _$MainDataToJson(MainData instance) => <String, dynamic>{
  'aqi': instance.aqi,
};

Components _$ComponentsFromJson(Map<String, dynamic> json) => Components(
  co: (json['co'] as num?)?.toDouble(),
  no: (json['no'] as num?)?.toDouble(),
  no2: (json['no2'] as num?)?.toDouble(),
  o3: (json['o3'] as num?)?.toDouble(),
  so2: (json['so2'] as num?)?.toDouble(),
  pm25: (json['pm25'] as num?)?.toDouble(),
  pm10: (json['pm10'] as num?)?.toDouble(),
  nh3: (json['nh3'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ComponentsToJson(Components instance) =>
    <String, dynamic>{
      'co': instance.co,
      'no': instance.no,
      'no2': instance.no2,
      'o3': instance.o3,
      'so2': instance.so2,
      'pm25': instance.pm25,
      'pm10': instance.pm10,
      'nh3': instance.nh3,
    };

PollutionData _$PollutionDataFromJson(Map<String, dynamic> json) =>
    PollutionData(
      dt: (json['dt'] as num?)?.toInt(),
      main: json['main'] == null
          ? null
          : MainData.fromJson(json['main'] as Map<String, dynamic>),
      components: json['components'] == null
          ? null
          : Components.fromJson(json['components'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PollutionDataToJson(PollutionData instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'main': instance.main,
      'components': instance.components,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
  coord: json['coord'] == null
      ? null
      : Coord.fromJson(json['coord'] as Map<String, dynamic>),
  list: (json['list'] as List<dynamic>?)
      ?.map((e) => PollutionData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'coord': instance.coord,
  'list': instance.list,
};
