class ServerConfig {
	static const String baseUrl = 'https://claritywallpaper.com';

	static const String authorization =
		'ZmY4MDgwODE2ZTI5NmJlNTAxNmUzNDkyMWExODE4ZmE=';

	static const String allCatalog =
		'/clarity/api/catalog/listAll?state=1&type=2';

	static final ServerConfig _sharedInstance = ServerConfig._internal();
	factory ServerConfig() {
		return _sharedInstance;
	}
	ServerConfig._internal();
}
