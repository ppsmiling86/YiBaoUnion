import 'package:dio/dio.dart';
import 'ServerConfig.dart';
import 'Response.dart';

class ApiProvider {

	static BaseOptions options = new BaseOptions(
//		headers: {"authorization": ServerConfig.authorization},
		connectTimeout: 50000,
		receiveTimeout: 30000,
	);
	Dio _dio = Dio(options);

	Future<UserLoginResponse> userLogin() async {
		try {
			Response response = await _dio.post(ServerConfig.baseUrl + ServerConfig.userLogin, data: {"mobile": "11111111111", "sms_code": "111","invite_code": "aaaaaa"});
			return UserLoginResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return UserLoginResponse.withError('$error');
		}
	}
}