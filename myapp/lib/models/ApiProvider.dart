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
			var data = {"mobile": mobile, "sms_code": sms_code,"invite_code": invite_code};
			Response response = await _dio.post(ServerConfig.baseUrl + ServerConfig.userLogin, data: data);
			printResponse(response);
			return UserLoginResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return UserLoginResponse.withError('$error');
		}
	}

	Future<SMSResponse> sms(String mobile) async {
		try {
			Response response = await _dio.get(ServerConfig.baseUrl + ServerConfig.sms, queryParameters: {"mobile": mobile});
			printResponse(response);
			return SMSResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return SMSResponse.withError('$error');
		}
	}

	Future<SMSResponse> smsSelf() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.smsSelf);
			printResponse(response);
			return SMSResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return SMSResponse.withError('$error');
		}
	}

	Future<ProductResponse> productInfo() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.productInfo);
			printResponse(response);
			return ProductResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return ProductResponse.withError('$error');
		}
	}

	Future<PlaceOrderResponse> placeOrder(int amount) async {
		try {
			Response response = await dio().post(ServerConfig.baseUrl + ServerConfig.placeOrder,data: {"amount": amount});
			printResponse(response);
			return PlaceOrderResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return PlaceOrderResponse.withError('$error');
		}
	}

	Future<GetOrderResponse> getOrder() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.getOder);
			printResponse(response);
			return GetOrderResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return GetOrderResponse.withError('$error');
		}
	}

	Future<DownlinkUserResponse> downlinkUser() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.downlinkUser);
			printResponse(response);
			return DownlinkUserResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return DownlinkUserResponse.withError('$error');
		}
	}

	Future<WithdrawAddressResponse> addWithDrawAddress(WithdrawAddressEntity withdrawAddressEntity) async {
		try {
			Response response = await dio().post(ServerConfig.baseUrl + ServerConfig.withdrawAddress,data: {"tag": withdrawAddressEntity.tag,"address": withdrawAddressEntity.address});
			printResponse(response);
			return WithdrawAddressResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return WithdrawAddressResponse.withError('$error');
		}
	}

	Future<WithdrawAddressResponse> deleteWithDrawAddress(WithdrawAddressEntity withdrawAddressEntity) async {
		try {
			Response response = await dio().delete(ServerConfig.baseUrl + ServerConfig.withdrawAddress,data: {"id": withdrawAddressEntity.id});
			printResponse(response);
			return WithdrawAddressResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return WithdrawAddressResponse.withError('$error');
		}
	}

	Future<WithdrawAddressResponse> editWithDrawAddress(WithdrawAddressEntity withdrawAddressEntity) async {
		try {
			Response response = await dio().put(ServerConfig.baseUrl + ServerConfig.withdrawAddress,data: {"id": withdrawAddressEntity.id,"tag": withdrawAddressEntity.tag,"address": withdrawAddressEntity.address});
			printResponse(response);
			return WithdrawAddressResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return WithdrawAddressResponse.withError('$error');
		}
	}

	Future<WithdrawAddressListResponse> getWithDrawAddress() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.withdrawAddress);
			printResponse(response);
			return WithdrawAddressListResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return WithdrawAddressListResponse.withError('$error');
		}
	}

	Future<PayStatusResponse> payStatus(String orderId) async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.payStatus,queryParameters: {"order_id": orderId});
			printResponse(response);
			return PayStatusResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return PayStatusResponse.withError('$error');
		}
	}

	Future<WithdrawListResponse> withdrawApply() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.withdrawApply,queryParameters: {"page": 0,"size":10000});
			printResponse(response);
			return WithdrawListResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return WithdrawListResponse.withError('$error');
		}
	}

	Future<ApplyWithdrawResponse> applyWithdraw(WithdrawRequest request) async {
		try {
			var data = {"value": request.amount,"address": request.walletAddress,"sms_code":request.verifyCode};
			print(data);
			Response response = await dio().post(ServerConfig.baseUrl + ServerConfig.withdrawApply,data: data);
			printResponse(response);
			return ApplyWithdrawResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return ApplyWithdrawResponse.withError('$error');
		}
	}

	Future<WithdrawAvailableResponse> withdrawAvailable() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.withdrawAvailable);
			printResponse(response);
			return WithdrawAvailableResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return WithdrawAvailableResponse.withError('$error');
		}
	}

	Future<UserInfoResponse> userInfo() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.userInfo);
			printResponse(response);
			return UserInfoResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return UserInfoResponse.withError('$error');
		}
	}

	Future<PayOrderResponse> payOrder(String order_id, int pay_type) async {
		try {
			print(order_id);
			print("${pay_type}");
			Response response = await dio().post(ServerConfig.baseUrl + ServerConfig.payOrder,data: {"order_id": order_id,"pay_type":pay_type});
			printResponse(response);
			return PayOrderResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return PayOrderResponse.withError('$error');
		}
	}

	Future<CancelOrderResponse> cancelOrder(String order_id) async {
		try {
			var data = {"order_id": order_id};
			Response response = await dio().post(ServerConfig.baseUrl + ServerConfig.cancelOder,data: data);
			printResponse(response);
			return CancelOrderResponse.fromJson(response.data);
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return CancelOrderResponse.withError('$error');
		}
	}

	void printResponse(Response response) {
		print("[${response.request.method} ${response.statusCode} :${response.request.path}]");
		print("[request data : ${response.request.data}]");
		print("[request queryParameters : ${response.request.queryParameters}]");
		print("[response data : ${response.data}]");
	}


}