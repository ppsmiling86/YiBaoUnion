import 'Response.dart';
import 'ApiProvider.dart';

class ApiRepository {
	ApiProvider _apiProvider = ApiProvider();
	Future<CatalogResponse> getCatalogs() {
		return _apiProvider.getAllCatalogs();
	}
}