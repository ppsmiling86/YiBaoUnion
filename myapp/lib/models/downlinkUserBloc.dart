import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class DownlinkUserBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<DownlinkUserResponse> _subject =
	BehaviorSubject<DownlinkUserResponse>();
	void downlinkUser() async {
		DownlinkUserResponse response = await _repository.downlinkUser();
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<DownlinkUserResponse> get subject => _subject;
}