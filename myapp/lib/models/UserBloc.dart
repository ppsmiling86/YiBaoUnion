import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<UserLoginResponse> _subject =
	BehaviorSubject<UserLoginResponse>();
	void userLogin(String mobile, String sms_code,String invite_code) async {
		UserLoginResponse response = await _repository.userLogin(mobile,sms_code,invite_code);
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<UserLoginResponse> get subject => _subject;
}