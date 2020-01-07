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
	final String uid;
	final String name;
	final String upperId;

	UserEntity(this.uid, this.name, this.upperId);

	factory UserEntity.fromJson(Map<String, dynamic> json) =>
		_$UserEntityFromJson(json);
}