class StringTools {

  //1开头，后面10位数字
  static bool ValidatePhoneNumber(String phoneStr){
    RegExp exp = RegExp(r"1[0-9]\d{9}$");
    return exp.hasMatch(phoneStr);
  }

  //6~16位数字和字符组合
  static bool ValidatePassword(String password) {
    RegExp exp = RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$");
    return exp.hasMatch(password);
  }

  //6位数字验证码
  static bool ValidateSmsCode(String smsCode) {
    RegExp exp = RegExp(r"\d{6}$");
    return exp.hasMatch(smsCode);
  }

  static bool ValidateNumber(String number) {
    if (!isNumeric(number)) {
      return false;
    }
    RegExp exp = RegExp(r"[0-9]{1,10}$");
    return exp.hasMatch(number) && double.parse(number) >= 0;
  }

  static bool ValidateWithdrawAddress(String number) {
    return number.length == 12;
  }

  static bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

}