import 'dart:html';

import 'package:universal_html/html.dart';
final kUpperInviteCode = "UpperInviteCode";
final kOrigin = "urlOrigin";
final kRedirectUrl = "redirectUrl";
class LocalStorageTools {
	static void setObject(String value, String forKey) {
		if (value is String && forKey is String) {
			if (forKey.length > 0) {
				Storage localStorage = window.localStorage;
				localStorage[forKey] = value;
			}
		}
	}

	static String object(String forKey) {
		if (forKey is String) {
			if (forKey.length > 0) {
				Storage localStorage = window.localStorage;
				return localStorage[forKey];
			}
		}
		return "";
	}

	static void saveInitRedirectUrl() {
		var url = window.location.href;
		if (url is String) {
			if (url == "http://www.longmonrent.com/?redirect=order_list#/") {
				LocalStorageTools.saveRedirectUrl(url);
			}
		}
	}

	static void saveUpperInviteCode() {
		var url = window.location.href;
		print("url is $url");
		Uri uri = Uri.parse(url.replaceAll("#/", ""));

		var urlOrigin = uri.origin;
		print("urlOrigin is ${urlOrigin}");
		var inviteCode = uri.queryParameters["invite_code"];
		if (inviteCode is String) {
			if (inviteCode.isNotEmpty) {
				print("parsed inviteCode is ${inviteCode}");
				LocalStorageTools.setObject(inviteCode, kUpperInviteCode);
			}
		}
		LocalStorageTools.setObject(urlOrigin, kOrigin);
	}

	static bool isRediretToOrderList() {
		var url = LocalStorageTools.object(kRedirectUrl);
		if (url is String) {
			if (url == "http://www.longmonrent.com/?redirect=order_list#/") {
				return true;
			}
		}
		return false;
	}

	static saveRedirectUrl(String redirectUrl) {
		LocalStorageTools.setObject(redirectUrl, kRedirectUrl);
	}

	static clearRedirectUrl() {
		LocalStorageTools.setObject("", kRedirectUrl);
	}

	static String getUpperInviteCode() {
		return LocalStorageTools.object(kUpperInviteCode);
	}

	static void clearUpperInviteCode() {
		LocalStorageTools.setObject("", kUpperInviteCode);
	}

	static String getOrigin() {
		return LocalStorageTools.object(kOrigin);
	}

}