import 'dart:html';
import 'dart:async';

class UserAgent {
	String getUserAgent() {
		String userAgent = window.navigator.userAgent;
		return userAgent;
	}
	bool isWeChatOpen() {
		return this.getUserAgent().toLowerCase().contains("micromessenger");
	}
}