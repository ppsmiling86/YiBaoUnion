
import 'package:url_launcher/url_launcher.dart';

class CallsAndMessagesService {
	void sendQQ(String number) => launch("mqqwpa://im/chat?chat_type=wpa&uin=$number&version=1&src_type=web&web_src=http:://wpa.b.qq.com");
	void call(String number) => launch("tel:$number");
	void sendWechat(String number) => launch("weixin://$number");
}
