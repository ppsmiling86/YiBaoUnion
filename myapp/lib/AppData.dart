class AppData {

	User loginUser;
	Registration tempRegistration = Registration("", "", "");

	static final AppData sharedInstance = AppData._internal();

	factory AppData() {
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
