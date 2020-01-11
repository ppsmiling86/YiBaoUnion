import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class WithdrawAvailableBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<WithdrawAvailableResponse> _subject =
	BehaviorSubject<WithdrawAvailableResponse>();

	void withdrawAvailable() async {
		WithdrawAvailableResponse response = await _repository.withdrawAvailable();
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<WithdrawAvailableResponse> get subject => _subject;
}