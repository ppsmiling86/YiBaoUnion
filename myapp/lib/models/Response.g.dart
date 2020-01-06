// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogResponse _$CatalogResponseFromJson(Map<String, dynamic> json) {
  return CatalogResponse(
    json['message'] as String,
    json['code'] as int,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CatalogEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CatalogResponseToJson(CatalogResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.catalogEntities,
    };

CatalogEntity _$CatalogEntityFromJson(Map<String, dynamic> json) {
  return CatalogEntity(
    json['id'] as String,
    json['enName'] as String,
    json['chName'] as String,
    json['rank'] as int,
    json['type'] as int,
    json['url'] as String,
    json['state'] as int,
  );
}

Map<String, dynamic> _$CatalogEntityToJson(CatalogEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enName': instance.enName,
      'chName': instance.chName,
      'rank': instance.rank,
      'type': instance.type,
      'url': instance.url,
      'state': instance.state,
    };
