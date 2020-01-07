import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<UserLoginResponse> _subject =
	BehaviorSubject<UserLoginResponse>();
	void userLogin() async {
		UserLoginResponse response = await _repository.userLogin();
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<UserLoginResponse> get subject => _subject;
}