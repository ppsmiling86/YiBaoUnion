import 'package:dio/dio.dart';
import 'ServerConfig.dart';
import 'Response.dart';
import 'AppData.dart';

class ApiProvider {

	static BaseOptions options = new BaseOptions(
		connectTimeout: 50000,
		receiveTimeout: 30000,
	);
	Dio _dio = Dio(options);

	Dio dio() {
		print("token is ${AppData().loginUser().token}");
		BaseOptions options = new BaseOptions(
			headers: {"authorization": AppData().loginUser().token},
			connectTimeout: 50000,
			receiveTimeout: 30000,
		);
		return Dio(options);
	}

	Future<UserLoginResponse> userLogin(String mobile, String sms_code, String invite_code) async {
		try {
			Response response = await _dio.post(ServerConfig.baseUrl + ServerConfig.userLogin, data: {"mobile": mobile, "sms_code": sms_code,"invite_code": invite_code});
			print(response);
			return UserLoginResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return UserLoginResponse.withError('$error');
		}
	}

	Future<SMSResponse> sms(String mobile) async {
		try {
			Response response = await _dio.get(ServerConfig.baseUrl + ServerConfig.sms, queryParameters: {"mobile": mobile});
			print(response);
			return SMSResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return SMSResponse.withError('$error');
		}
	}

	Future<SMSResponse> downlinkUser() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.downlinkUser);
			print(response);
			return SMSResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return SMSResponse.withError('$error');
		}
	}

	Future<ProductResponse> productInfo() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.productInfo);
			print(response);
			var pr = ProductResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return ProductResponse.withError('$error');
		}
	}

	Future<PlaceOrderResponse> placeOrder(int amount) async {
		try {
			Response response = await dio().post(ServerConfig.baseUrl + ServerConfig.placeOrder,data: {"amount": amount});
			print(response);
			var pr = PlaceOrderResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return PlaceOrderResponse.withError('$error');
		}
	}

	Future<GetOrderResponse> getOrder() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.getOder);
			print(response);
			var pr = GetOrderResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return GetOrderResponse.withError('$error');
		}
	}

}