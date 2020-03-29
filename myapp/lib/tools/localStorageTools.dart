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
		print("redirect url is $url");
		if (url == null) {
			print("url is null");
			return false;
		}

		Uri uri = Uri.parse(url.replaceAll("#/", ""));
		print("uri.queryParameters ${uri.queryParameters}");
		var redirectPath = uri.queryParameters["redirect"];
		print("redirectPath is $redirectPath");
		if (redirectPath == null) {
			print("redirectPath is null");
			return false;
		}

		if (redirectPath is String) {
			if (redirectPath.isNotEmpty) {
				print("redirectPath is $redirectPath");
				bool isOrderList = (redirectPath == "order_list");
				print("this is order list redirect, will show order list");
				return isOrderList;
			} else {
				print("redirectPath is $redirectPath");
			}
		} else {
			print("redirectPath is $redirectPath");
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