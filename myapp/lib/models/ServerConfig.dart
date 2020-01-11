class ServerConfig {
	static const String baseUrl = 'http://34.92.152.68/api';
//	static const String baseUrl = 'http://192.168.99.248:28080';

	static const String userLogin = '/user/login';
	static const String sms = '/sms';
	static const String smsSelf = '/sms/self';
	static const String downlinkUser = '/downlink/user';
	static const String productInfo = '/product/info';
	static const String placeOrder = '/order';
	static const String getOder = '/order';
	static const String withdrawAddress = '/withdraw/address';
	static const String payStatus = '/pay/status';
	static const String withdrawApply = '/withdraw/apply';
	static const String withdrawAvailable = '/withdraw/available';

	static final ServerConfig _sharedInstance = ServerConfig._internal();
	factory ServerConfig() {
		return _sharedInstance;
	}
	ServerConfig._internal();
}

