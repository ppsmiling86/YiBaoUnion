import 'Response.dart';
import 'ApiProvider.dart';

class ApiRepository {
	ApiProvider _apiProvider = ApiProvider();
	Future<UserLoginResponse> userLogin() {
		return _apiProvider.userLogin();
	}
}