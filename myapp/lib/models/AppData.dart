import 'dart:html';
import 'package:myapp/models/ApiProvider.dart';
import 'package:myapp/models/Response.dart';
import 'ServerConfig.dart';

final kLoginPhoneNumber = "loginPhoneNumber";
final kInviteCode = "inviteCode";
final kToken = "yibao_token";

class AppData {
	Registration tempRegistration = Registration("", "", "");
	WithdrawRequest withdrawRequest = WithdrawRequest("", 0,"");
	OrderRequest orderRequest = OrderRequest();

	static final AppData sharedInstance = AppData._internal();

	factory AppData() {
		return sharedInstance;
	}

	AppData._internal();

	User loginUser() {
		Storage localStorage = window.localStorage;
		if(localStorage[kLoginPhoneNumber] != null && localStorage[kLoginPhoneNumber].isNotEmpty &&
			localStorage[kToken] != null && localStorage[kToken].isNotEmpty &&
			localStorage[kInviteCode] != null && localStorage[kInviteCode].isNotEmpty) {
			return User(localStorage[kToken],true, localStorage[kLoginPhoneNumber], localStorage[kInviteCode]);
		}
		return User("", false, "", "");
	}

}

class User {
	final _apiProvider = ApiProvider();
	bool isLoggedIn;
	String mobile;
	String inviteCode;
	String token;
	UserEntity userEntity;

	User(
		this.token,
		this.isLoggedIn,
		this.mobile,
		this.inviteCode,
		);

	Future<SMSResponse> sms(Registration reg) async {
		SMSResponse response = await _apiProvider.sms(reg.mobile);
		return response;
	}

	Future<UserLoginResponse> login(Registration reg) async {
		UserLoginResponse response = await _apiProvider.userLogin(reg.mobile, reg.verifyCode, reg.inviteCode);
		if (response.data != null) {
			this.token = response.data.token;
			this.inviteCode = response.data.invite_code;
			this.mobile = response.data.uid;
			this.isLoggedIn = true;
			this.userEntity = response.data;
			this.save();
		}
		return response;
	}

	void save() {
		Storage localStorage = window.localStorage;
		localStorage[kLoginPhoneNumber] = this.mobile;
		localStorage[kInviteCode] = this.inviteCode;
		localStorage[kToken] = this.token;
	}

	void logout() {
		Storage localStorage = window.localStorage;
		localStorage[kLoginPhoneNumber] = "";
		localStorage[kInviteCode] = "";
		localStorage[kToken] = "";
	}
}

class OrderRequest {
	int amount;
}

class Registration {
	String mobile;
	String verifyCode;
	String inviteCode;
	Registration(
		this.mobile,
		this.verifyCode,
		this.inviteCode
		);
}

enum WithdrawStatus {
	processing,
	succeed,
	failed,
}

class WithdrawRecord {
	double credits;
	String dateTime;

	WithdrawStatus status;

	WithdrawRecord(
		this.credits,
		this.dateTime,
		this.status,
		);

	String buildStatusStr() {
		if (this.status == WithdrawStatus.processing) {
			return "审核中";
		}

		if (this.status == WithdrawStatus.succeed) {
			return "成功";
		}

		if (this.status == WithdrawStatus.failed) {
			return "失败";
		}
		return "";
	}
}

class WithdrawRequest {
	String walletAddress;
	double amount;
	String verifyCode;
	WithdrawRequest(
		this.walletAddress,
		this.amount,
		this.verifyCode,
		);
}
