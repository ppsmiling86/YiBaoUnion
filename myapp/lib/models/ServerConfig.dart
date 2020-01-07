class ServerConfig {
	static const String baseUrl = 'http://172.20.10.13:18080';

	static const String authorization =
		'ZmY4MDgwODE2ZTI5NmJlNTAxNmUzNDkyMWExODE4ZmE=';

	static const String userLogin =
		'/user/login';

	static final ServerConfig _sharedInstance = ServerConfig._internal();
	factory ServerConfig() {
		return _sharedInstance;
	}
	ServerConfig._internal();
}
