
import 'package:universal_html/prefer_universal/html.dart' as html;

class CallsAndMessagesService {
	void sendQQ(String number) => launchURL("mqqwpa://im/chat?chat_type=wpa&uin=$number&version=1&src_type=web&web_src=http:://wpa.b.qq.com");
	void call(String number) => launchURL("tel:$number");
	void sendWechat(String number) => launchURL("weixin://$number");

	String getSendQQUrl(String number) {
		return "mqqwpa://im/chat?chat_type=wpa&uin=$number&version=1&src_type=web&web_src=http:://wpa.b.qq.com";
	}

	String getSendWechat(String number) {
		return "weixin://dl/chat";
	}

	void launchURL(String urlStr) async {
		html.window.location.assign(urlStr);
	}
}
