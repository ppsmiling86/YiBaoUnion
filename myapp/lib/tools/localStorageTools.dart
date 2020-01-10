import 'dart:html';
final kUpperInviteCode = "UpperInviteCode";
class LocalStorageTools {
	static void setObject(String value, String forKey) {
		if (value is String && forKey is String) {
			if (value.length > 0 && forKey.length > 0) {
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
		Uri uri = Uri.dataFromString("url");
		var inviteCode = uri.queryParameters["inviteCode"];
		LocalStorageTools.setObject(inviteCode, kUpperInviteCode);
	}

	static String getUpperInviteCode() {

		return LocalStorageTools.object(kUpperInviteCode);
	}

}