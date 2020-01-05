class AppData {

	User loginUser;
	Registration tempRegistration = Registration("", "", "");
	WithdrawRequest withdrawRequest = WithdrawRequest("", 0);

	static final AppData sharedInstance = AppData._internal();

	factory AppData() {
		if(sharedInstance.loginUser == null) {
			sharedInstance.loginUser = User(false, "","", 0, 0, 0, []);
		}
		return sharedInstance;
	}

	AppData._internal();

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
		this.loginPhoneNumber = reg.mobile;
		this.isLoggedIn = true;
		this.inviteCode = reg.inviteCode;
	}

	void logout() {
		this.loginPhoneNumber = "";
		this.isLoggedIn = false;
		this.inviteCode = "";
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
	WithdrawRequest(
		this.walletAddress,
		this.amount,
		);
}
