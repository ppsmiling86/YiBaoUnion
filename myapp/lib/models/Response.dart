import 'package:json_annotation/json_annotation.dart';

// flutter packages pub run build_runner watch --delete-conflicting-outputs

@JsonSerializable()
class CatalogResponse extends Object {
	final String message;
	final int code;

	@JsonKey(name: 'data')
	final List<CatalogEntity> catalogEntities;

	CatalogResponse(
		this.message,
		this.code,
		this.catalogEntities,
		);

	factory CatalogResponse.fromJson(Map<String, dynamic> json) =>
		_$CatalogResponseFromJson(json);

	CatalogResponse.withError(String error)
		: catalogEntities = List(),
			code = -1,
			message = error;
}

@JsonSerializable()
class CatalogEntity extends Object {
	final String id;
	final String enName;
	final String chName;
	final int rank;
	final int type;
	final String url;
	final int state;
	CatalogEntity(this.id, this.enName, this.chName, this.rank, this.type,
		this.url, this.state);

	factory CatalogEntity.fromJson(Map<String, dynamic> json) =>
		_$CatalogEntityFromJson(json);
}