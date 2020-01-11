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

	Future<SMSResponse> smsSelf() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.smsSelf);
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

	Future<DownlinkUserResponse> downlinkUser() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.downlinkUser);
			print(response);
			var pr = DownlinkUserResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return DownlinkUserResponse.withError('$error');
		}
	}

	Future<WithdrawAddressResponse> addWithDrawAddress(WithdrawAddressEntity withdrawAddressEntity) async {
		try {
			Response response = await dio().post(ServerConfig.baseUrl + ServerConfig.withdrawAddress,data: {"tag": withdrawAddressEntity.tag,"address": withdrawAddressEntity.address});
			print(response);
			var pr = WithdrawAddressResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return WithdrawAddressResponse.withError('$error');
		}
	}

	Future<WithdrawAddressResponse> deleteWithDrawAddress(WithdrawAddressEntity withdrawAddressEntity) async {
		try {
			Response response = await dio().delete(ServerConfig.baseUrl + ServerConfig.withdrawAddress,data: {"id": withdrawAddressEntity.id});
			print(response);
			var pr = WithdrawAddressResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return WithdrawAddressResponse.withError('$error');
		}
	}

	Future<WithdrawAddressResponse> editWithDrawAddress(WithdrawAddressEntity withdrawAddressEntity) async {
		try {
			Response response = await dio().put(ServerConfig.baseUrl + ServerConfig.withdrawAddress,data: {"id": withdrawAddressEntity.id,"tag": withdrawAddressEntity.tag,"address": withdrawAddressEntity.address});
			print(response);
			var pr = WithdrawAddressResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return WithdrawAddressResponse.withError('$error');
		}
	}

	Future<WithdrawAddressListResponse> getWithDrawAddress() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.withdrawAddress);
			print(response);
			var pr = WithdrawAddressListResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return WithdrawAddressListResponse.withError('$error');
		}
	}

	Future<PayStatusResponse> payStatus(String orderId) async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.payStatus,queryParameters: {"order_id": orderId});
			print(response);
			var pr = PayStatusResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return PayStatusResponse.withError('$error');
		}
	}

	Future<WithdrawListResponse> withdrawApply() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.withdrawApply,queryParameters: {"page": 0,"size":10000});
			print(response);
			var pr = WithdrawListResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
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
			print(response);
			var pr = ApplyWithdrawResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return ApplyWithdrawResponse.withError('$error');
		}
	}

	Future<WithdrawAvailableResponse> withdrawAvailable() async {
		try {
			Response response = await dio().get(ServerConfig.baseUrl + ServerConfig.withdrawAvailable);
			print(response);
			var pr = WithdrawAvailableResponse.fromJson(response.data);
			print("pr is ${pr.data}");
			return pr;
		} catch (error, stacktrace) {
			print('Exception occured:$error stackTrace: $stacktrace');
			return WithdrawAvailableResponse.withError('$error');
		}
	}

}