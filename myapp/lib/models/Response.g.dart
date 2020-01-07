// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginResponse _$UserLoginResponseFromJson(Map<String, dynamic> json) {
  return UserLoginResponse(
    json['msg'] as String,
    json['code'] as String,
    json['data'] == null
        ? null
        : UserEntity.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserLoginResponseToJson(UserLoginResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'data': instance.data,
    };

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return UserEntity(
    json['uid'] as String,
    json['name'] as String,
    json['upperId'] as String,
  );
}

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'upperId': instance.upperId,
    };
