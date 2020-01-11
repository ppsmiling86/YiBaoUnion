
import 'package:myapp/models/ApiProvider.dart';
import 'package:myapp/models/Response.dart';
import 'package:myapp/tools/localStorageTools.dart';

final kLoginPhoneNumber = "loginPhoneNumber";
final kInviteCode = "inviteCode";
final kToken = "yibao_token";

class AppData {
	Registration tempRegistration = Registration("", "", "");
	WithdrawRequest withdrawRequest = WithdrawRequest("", 0,"");
	OrderRequest orderRequest = OrderRequest();
	User currentLoginUser = null;
	static final AppData sharedInstance = AppData._internal();

	factory AppData() {
		return sharedInstance;
	}

	AppData._internal();

	User loginUser() {
		if (currentLoginUser == null) {
			var loginPhoneNumber = LocalStorageTools.object(kLoginPhoneNumber);
			var token = LocalStorageTools.object(kToken);
			var inviteCode = LocalStorageTools.object(kInviteCode);
			print("local saved phone: ${loginPhoneNumber}, token: ${token}, inviteCode:${inviteCode}");
			if(loginPhoneNumber != null && loginPhoneNumber.isNotEmpty &&
				token != null && token.isNotEmpty &&
				inviteCode != null && inviteCode.isNotEmpty) {
				print("start by login");
				currentLoginUser = User(token,true, loginPhoneNumber, inviteCode);
			} else {
				print("start by not login");
				currentLoginUser = User("", false, "", "");
			}
		}
		return currentLoginUser;
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
		LocalStorageTools.setObject(this.mobile, kLoginPhoneNumber);
		LocalStorageTools.setObject(this.inviteCode, kInviteCode);
		LocalStorageTools.setObject(this.token, kToken);
	}

	void logout() {
		print("do logout");
		this.isLoggedIn = false;
		this.token = "";
		this.inviteCode = "";
		this.mobile = "";
		this.userEntity = null;

		print("clear local data...");


		LocalStorageTools.setObject("", kLoginPhoneNumber);
		LocalStorageTools.setObject("", kToken);
		LocalStorageTools.setObject("", kInviteCode);

		print("must no login phone number: ${LocalStorageTools.object(kLoginPhoneNumber)}");
		print("must no token: ${LocalStorageTools.object(kToken)}");
		print("must no invite code: ${LocalStorageTools.object(kInviteCode)}");


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
