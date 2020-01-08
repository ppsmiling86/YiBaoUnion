import 'dart:html';

class AppData {
	Registration tempRegistration = Registration("", "", "");
	WithdrawRequest withdrawRequest = WithdrawRequest("", 0,"");

	static final AppData sharedInstance = AppData._internal();

	factory AppData() {
		return sharedInstance;
	}

	AppData._internal();

	User loginUser() {
		Storage localStorage = window.localStorage;
		if(localStorage["loginPhoneNumber"] != null && localStorage["loginPhoneNumber"].isNotEmpty) {
			return User(true, localStorage["loginPhoneNumber"], localStorage["inviteCode"], 1000, 1000, 1000, []);
		}
		return User(false, "", "", 0, 0, 0, []);
	}

}

class User {
	bool isLoggedIn;
	String loginPhoneNumber;
	String inviteCode;
	double credits;
	double totalCalculatorPower;
	double creditsCanGenerateToday;

	List<Order>orderList;

	User(
		this.isLoggedIn,
		this.loginPhoneNumber,
		this.inviteCode,
		this.credits,
		this.creditsCanGenerateToday,
		this.totalCalculatorPower,
		this.orderList
		);

	void login(Registration reg) {
		Storage localStorage = window.localStorage;
		localStorage["loginPhoneNumber"] = reg.mobile;
		localStorage["inviteCode"] = reg.inviteCode;
	}

	void logout() {
		Storage localStorage = window.localStorage;
		localStorage["loginPhoneNumber"] = "";
		localStorage["inviteCode"] = "";
	}
}

class Order {
	String orderId;
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
