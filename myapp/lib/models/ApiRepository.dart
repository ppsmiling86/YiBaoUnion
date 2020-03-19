import 'package:myapp/models/AppData.dart';

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

	Future<SMSResponse> smsSelf() {
		return _apiProvider.smsSelf();
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

	Future<DownlinkUserResponse> downlinkUser() {
		return _apiProvider.downlinkUser();
	}

	Future<WithdrawAddressResponse> addWithdrawAddress(WithdrawAddressEntity withdrawAddressEntity) {
		return _apiProvider.addWithDrawAddress(withdrawAddressEntity);
	}

	Future<WithdrawAddressResponse> deleteWithdrawAddress(WithdrawAddressEntity withdrawAddressEntity) {
		return _apiProvider.deleteWithDrawAddress(withdrawAddressEntity);
	}

	Future<WithdrawAddressResponse> editWithdrawAddress(WithdrawAddressEntity withdrawAddressEntity) {
		return _apiProvider.editWithDrawAddress(withdrawAddressEntity);
	}

	Future<WithdrawAddressListResponse> getWithdrawAddress() {
		return _apiProvider.getWithDrawAddress();
	}

	Future<PayStatusResponse> payStatus(String orderId) {
		return _apiProvider.payStatus(orderId);
	}

	Future<WithdrawListResponse> withdrawApply() {
		return _apiProvider.withdrawApply();
	}

	Future<ApplyWithdrawResponse> applyWithdraw(WithdrawRequest withdrawRequest) {
		return _apiProvider.applyWithdraw(withdrawRequest);
	}

	Future<WithdrawAvailableResponse> withdrawAvailable() {
		return _apiProvider.withdrawAvailable();
	}

	Future<UserInfoResponse> userInfo() {
		return _apiProvider.userInfo();
	}

	Future<PayOrderResponse> payOrder(String order_id, int pay_type) {
		return _apiProvider.payOrder(order_id, pay_type);
	}

	Future<CancelOrderResponse> cancelOrder(String order_id) {
		return _apiProvider.cancelOrder(order_id);
	}

	Future<PayOrderWeiXinH5Response> payOrderWinXinH5(order_id) {
		return _apiProvider.payOrderWinXinH5(order_id);
	}
}