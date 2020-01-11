import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class UserInfoBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<UserInfoResponse> _subject =
	BehaviorSubject<UserInfoResponse>();
	void userInfo() async {
		UserInfoResponse response = await _repository.userInfo();
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<UserInfoResponse> get subject => _subject;
}