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
    (json['balance'] as num)?.toDouble(),
    json['invitor_id'] as String,
    json['created_at'] as int,
    json['upper_id1'] as String,
    json['upper_id2'] as String,
    json['id'] as String,
    json['invite_code'] as String,
    json['token'] as String,
  );
}

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'balance': instance.balance,
      'invitor_id': instance.invitor_id,
      'created_at': instance.created_at,
      'name': instance.name,
      'upper_id1': instance.upper_id1,
      'upper_id2': instance.upper_id2,
      'id': instance.id,
      'invite_code': instance.invite_code,
      'token': instance.token,
    };

SMSResponse _$SMSResponseFromJson(Map<String, dynamic> json) {
  return SMSResponse(
    json['msg'] as String,
    json['code'] as String,
    json['data'] == null
        ? null
        : SMSEntity.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SMSResponseToJson(SMSResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'data': instance.data,
    };

SMSEntity _$SMSEntityFromJson(Map<String, dynamic> json) {
  return SMSEntity(
    json['result'] as String,
    (json['duration'] as num)?.toDouble(),
    json['expiredAt'] as int,
    json['code'] as String,
  );
}

Map<String, dynamic> _$SMSEntityToJson(SMSEntity instance) => <String, dynamic>{
      'result': instance.result,
      'duration': instance.duration,
      'expiredAt': instance.expiredAt,
      'code': instance.code,
    };

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) {
  return ProductResponse(
    json['msg'] as String,
    json['code'] as String,
    json['data'] == null
        ? null
        : ProductEntity.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'data': instance.data,
    };

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) {
  return ProductEntity(
    (json['sold_progress'] as num)?.toDouble(),
    json['total_supply'] as int,
    (json['price'] as num)?.toDouble(),
    (json['finished_progress'] as num)?.toDouble(),
    json['limit_per_user'] as int,
  );
}

Map<String, dynamic> _$ProductEntityToJson(ProductEntity instance) =>
    <String, dynamic>{
      'sold_progress': instance.sold_progress,
      'total_supply': instance.total_supply,
      'price': instance.price,
      'finished_progress': instance.finished_progress,
      'limit_per_user': instance.limit_per_user,
    };

CommissionResponse _$CommissionResponseFromJson(Map<String, dynamic> json) {
  return CommissionResponse(
    json['msg'] as String,
    json['code'] as String,
    json['data'] == null
        ? null
        : ProductEntity.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommissionResponseToJson(CommissionResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'data': instance.data,
    };

CommissionEntity _$CommissionEntityFromJson(Map<String, dynamic> json) {
  return CommissionEntity(
    json['uid'] as String,
    (json['commission'] as num)?.toDouble(),
    json['level'] as int,
    json['charge_at'] as int,
  );
}

Map<String, dynamic> _$CommissionEntityToJson(CommissionEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'commission': instance.commission,
      'level': instance.level,
      'charge_at': instance.charge_at,
    };

PlaceOrderResponse _$PlaceOrderResponseFromJson(Map<String, dynamic> json) {
  return PlaceOrderResponse(
    json['msg'] as String,
    json['code'] as String,
    json['data'] == null
        ? null
        : PlaceOrderEntity.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PlaceOrderResponseToJson(PlaceOrderResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'data': instance.data,
    };

PlaceOrderEntity _$PlaceOrderEntityFromJson(Map<String, dynamic> json) {
  return PlaceOrderEntity(
    json['amount'] as int,
    json['created_at'] as int,
    json['upper_id1'] as String,
    json['pid'] as String,
    json['upper_id2'] as String,
    json['rent_start_at'] as int,
    json['rent_duraton'] as int,
    json['uid'] as String,
    (json['price'] as num)?.toDouble(),
    (json['progress'] as num)?.toDouble(),
    json['rent_end_at'] as int,
    json['id'] as String,
    (json['value'] as num)?.toDouble(),
    json['payed'] as bool,
    json['status'] as int,
  );
}

Map<String, dynamic> _$PlaceOrderEntityToJson(PlaceOrderEntity instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'created_at': instance.created_at,
      'upper_id1': instance.upper_id1,
      'pid': instance.pid,
      'upper_id2': instance.upper_id2,
      'rent_start_at': instance.rent_start_at,
      'rent_duraton': instance.rent_duraton,
      'uid': instance.uid,
      'price': instance.price,
      'progress': instance.progress,
      'rent_end_at': instance.rent_end_at,
      'id': instance.id,
      'value': instance.value,
      'payed': instance.payed,
      'status': instance.status,
    };

GetOrderResponse _$GetOrderResponseFromJson(Map<String, dynamic> json) {
  return GetOrderResponse(
    json['msg'] as String,
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PlaceOrderEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetOrderResponseToJson(GetOrderResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'data': instance.data,
    };

DownlinkUserResponse _$DownlinkUserResponseFromJson(Map<String, dynamic> json) {
  return DownlinkUserResponse(
    json['msg'] as String,
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : DownlinkUserEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DownlinkUserResponseToJson(
        DownlinkUserResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'data': instance.data,
    };

DownlinkUserEntity _$DownlinkUserEntityFromJson(Map<String, dynamic> json) {
  return DownlinkUserEntity(
    json['uid'] as String,
    (json['total_buy_score'] as num)?.toDouble(),
    json['created_at'] as int,
    (json['commission'] as num)?.toDouble(),
    json['level'] as int,
    json['ratio'] as String,
  );
}

Map<String, dynamic> _$DownlinkUserEntityToJson(DownlinkUserEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'total_buy_score': instance.total_buy_score,
      'created_at': instance.created_at,
      'commission': instance.commission,
      'level': instance.level,
      'ratio': instance.ratio,
    };

WithdrawAddressListResponse _$WithdrawAddressListResponseFromJson(
    Map<String, dynamic> json) {
  return WithdrawAddressListResponse(
    json['msg'] as String,
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : WithdrawAddressEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WithdrawAddressListResponseToJson(
        WithdrawAddressListResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'data': instance.data,
    };

WithdrawAddressEntity _$WithdrawAddressEntityFromJson(
    Map<String, dynamic> json) {
  return WithdrawAddressEntity(
    json['id'] as String,
    json['tag'] as String,
    json['address'] as String,
  );
}

Map<String, dynamic> _$WithdrawAddressEntityToJson(
        WithdrawAddressEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'address': instance.address,
    };

WithdrawAddressResponse _$WithdrawAddressResponseFromJson(
    Map<String, dynamic> json) {
  return WithdrawAddressResponse(
    json['msg'] as String,
    json['code'] as String,
    json['data'] == null
        ? null
        : WithdrawAddressEntity.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WithdrawAddressResponseToJson(
        WithdrawAddressResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'data': instance.data,
    };
