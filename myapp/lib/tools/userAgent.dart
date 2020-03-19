import 'package:user_agent/user_agent.dart';
import 'dart:async';

class Use1rAgent {
	static Future<bool> isWeChatOpen() async {
		var ua = new UserAgent(
			'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36');
		print(ua.isChrome);
		print(ua.isSafari);
		print(ua.isWebKit);
	}
}