import 'package:json_annotation/json_annotation.dart';
part 'Response.g.dart';
// flutter packages pub run build_runner watch --delete-conflicting-outputs

@JsonSerializable()
class UserLoginResponse extends Object {
	final String msg;
	final String code;
	final UserEntity data;

	UserLoginResponse(
		this.msg,
		this.code,
		this.data,
		);

	factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
		_$UserLoginResponseFromJson(json);

	UserLoginResponse.withError(String error)
		: data = null,
			code = "-1",
			msg = error;
}

@JsonSerializable()
class UserEntity extends Object {
	final String uid; // user id
	final double balance;
	final String invitor_id; // equal upper_id1 may be null
	final int created_at;
	final String name;
	final String upper_id1;
	final String upper_id2;
	final String id; // ignore
	final String invite_code;
	final String token;

	UserEntity(this.uid, this.name, this.balance, this.invitor_id, this.created_at, this.upper_id1, this.upper_id2, this.id, this.invite_code, this.token);

	factory UserEntity.fromJson(Map<String, dynamic> json) =>
		_$UserEntityFromJson(json);
}

@JsonSerializable()
class SMSResponse extends Object {
	final String msg;
	final String code;
	final SMSEntity data;

	SMSResponse(
		this.msg,
		this.code,
		this.data,
		);

	factory SMSResponse.fromJson(Map<String, dynamic> json) =>
		_$SMSResponseFromJson(json);

	SMSResponse.withError(String error)
		: data = null,
			code = "-1",
			msg = error;
}

@JsonSerializable()
class SMSEntity extends Object {
	final String result;
	final double duration;
	final int expiredAt;
	final String code;

	SMSEntity(this.result, this.duration, this.expiredAt, this.code);

	factory SMSEntity.fromJson(Map<String, dynamic> json) =>
		_$SMSEntityFromJson(json);
}

@JsonSerializable()
class ProductResponse extends Object {
	final String msg;
	final String code;
	final ProductEntity data;

	ProductResponse(
		this.msg,
		this.code,
		this.data,
		);

	factory ProductResponse.fromJson(Map<String, dynamic> json) =>
		_$ProductResponseFromJson(json);

	ProductResponse.withError(String error)
		: data = null,
			code = "-1",
			msg = error;
}

@JsonSerializable()
class ProductEntity extends Object {
	final double sold_progress;
	final int total_supply;
	final double price;
	final double finished_progress;
	final int limit_per_user;


	ProductEntity(this.sold_progress, this.total_supply, this.price, this.finished_progress, this.limit_per_user);

	factory ProductEntity.fromJson(Map<String, dynamic> json) =>
		_$ProductEntityFromJson(json);
}

@JsonSerializable()
class CommissionResponse extends Object {
	final String msg;
	final String code;
	final ProductEntity data;

	CommissionResponse(
		this.msg,
		this.code,
		this.data,
		);

	factory CommissionResponse.fromJson(Map<String, dynamic> json) =>
		_$CommissionResponseFromJson(json);

	CommissionResponse.withError(String error)
		: data = null,
			code = "-1",
			msg = error;
}

@JsonSerializable()
class CommissionEntity extends Object {
	final String uid;
	final double commission;
	final int level;
	final int charge_at; // 发奖时间


	CommissionEntity(this.uid, this.commission, this.level, this.charge_at);

	factory CommissionEntity.fromJson(Map<String, dynamic> json) =>
		_$CommissionEntityFromJson(json);
}

@JsonSerializable()
class PlaceOrderResponse extends Object {
	final String msg;
	final String code;
	final PlaceOrderEntity data;

	PlaceOrderResponse(
		this.msg,
		this.code,
		this.data,
		);

	factory PlaceOrderResponse.fromJson(Map<String, dynamic> json) =>
		_$PlaceOrderResponseFromJson(json);

	PlaceOrderResponse.withError(String error)
		: data = null,
			code = "-1",
			msg = error;
}

@JsonSerializable()
class PlaceOrderEntity extends Object {
	final int amount;
	final int created_at;
	final String upper_id1;
	final String pid;
	final String upper_id2;
	final int rent_start_at;
	final int rent_duraton;
	final String uid;
	final double price;
	final double progress;
	final int rent_end_at;
	final String id;
	final double value;
	final bool payed;
	final int status;


	PlaceOrderEntity(this.amount, this.created_at, this.upper_id1, this.pid, this.upper_id2, this.rent_start_at, this.rent_duraton, this.uid, this.price, this.progress, this.rent_end_at, this.id, this.value, this.payed, this.status);

	factory PlaceOrderEntity.fromJson(Map<String, dynamic> json) =>
		_$PlaceOrderEntityFromJson(json);
}

@JsonSerializable()
class GetOrderResponse extends Object {
	final String msg;
	final String code;
	final List<PlaceOrderEntity> data;

	GetOrderResponse(
		this.msg,
		this.code,
		this.data,
		);

	factory GetOrderResponse.fromJson(Map<String, dynamic> json) =>
		_$GetOrderResponseFromJson(json);

	GetOrderResponse.withError(String error)
		: data = null,
			code = "-1",
			msg = error;
}


@JsonSerializable()
class DownlinkUserResponse extends Object {
	final String msg;
	final String code;
	final List<DownlinkUserEntity> data;

	DownlinkUserResponse(
		this.msg,
		this.code,
		this.data,
		);

	factory DownlinkUserResponse.fromJson(Map<String, dynamic> json) =>
		_$DownlinkUserResponseFromJson(json);

	DownlinkUserResponse.withError(String error)
		: data = null,
			code = "-1",
			msg = error;
}

@JsonSerializable()
class DownlinkUserEntity extends Object {

	final String uid;
	final double total_buy_score;
	final int created_at;
	final double commission;
	final int level;
	final String ratio;

	DownlinkUserEntity(this.uid, this.total_buy_score, this.created_at, this.commission, this.level, this.ratio);

	factory DownlinkUserEntity.fromJson(Map<String, dynamic> json) =>
		_$DownlinkUserEntityFromJson(json);
}

@JsonSerializable()
class WithdrawAddressListResponse extends Object {
	final String msg;
	final String code;
	final List<WithdrawAddressEntity> data;

	WithdrawAddressListResponse(
		this.msg,
		this.code,
		this.data,
		);

	factory WithdrawAddressListResponse.fromJson(Map<String, dynamic> json) =>
		_$WithdrawAddressListResponseFromJson(json);

	WithdrawAddressListResponse.withError(String error)
		: data = null,
			code = "-1",
			msg = error;
}

@JsonSerializable()
class WithdrawAddressEntity extends Object {
	final String id;
	final String tag;
	final String address;

	WithdrawAddressEntity(this.id, this.tag, this.address);

	factory WithdrawAddressEntity.fromJson(Map<String, dynamic> json) =>
		_$WithdrawAddressEntityFromJson(json);
}

@JsonSerializable()
class WithdrawAddressResponse extends Object {
	final String msg;
	final String code;
	final WithdrawAddressEntity data;

	WithdrawAddressResponse(
		this.msg,
		this.code,
		this.data,
		);

	factory WithdrawAddressResponse.fromJson(Map<String, dynamic> json) =>
		_$WithdrawAddressResponseFromJson(json);

	WithdrawAddressResponse.withError(String error)
		: data = null,
			code = "-1",
			msg = error;
}