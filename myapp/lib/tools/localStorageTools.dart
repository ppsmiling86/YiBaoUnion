import 'dart:html';
final kUpperInviteCode = "UpperInviteCode";
final kOrigin = "urlOrigin";
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
		var url = window.location.href;
		print("isRediretToOrderList url is $url");
		Uri uri = Uri.parse(url.replaceAll("#/", ""));

		var urlOrigin = uri.origin;
		print("isRediretToOrderList urlOrigin is ${urlOrigin}");
		var redirectPath = uri.queryParameters["reidrect"];
		if (redirectPath is String) {
			if (redirectPath.isNotEmpty) {
				print("redirectPath is $redirectPath");
				return redirectPath == "order_list";
			}
		}
		return false;
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