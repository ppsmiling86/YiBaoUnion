import 'package:dio/dio.dart';
import 'ServerConfig.dart';

class ApiProvider {

	static BaseOptions options = new BaseOptions(
		headers: {"authorization": ServerConfig.authorization},
		connectTimeout: 50000,
		receiveTimeout: 30000,
	);
	Dio _dio = Dio(options);

	Future<CatalogResponse> getAllCatalogs() async {
		try {
			Response response =
			await _dio.get(ServerConfig.baseUrl + ServerConfig.allCatalog);
			return CatalogResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return CatalogResponse.withError('$error');
		}
	}
}