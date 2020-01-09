import 'Response.dart';
import 'ApiProvider.dart';

class ApiRepository {
	ApiProvider _apiProvider = ApiProvider();
	Future<UserLoginResponse> userLogin(String mobile, String sms_code, String invite_code) {
		return _apiProvider.userLogin(mobile,sms_code,invite_code);
	}

	Future<SMSResponse> sms(String mobile) {
		return _apiProvider.sms(mobile);
	}

	Future<ProductResponse> productInfo() {
		return _apiProvider.productInfo();
	}

	Future<PlaceOrderResponse> placeOrder(int amount) {
		return _apiProvider.placeOrder(amount);
	}

	Future<GetOrderResponse> getOrder() {
		return _apiProvider.getOrder();
	}
}