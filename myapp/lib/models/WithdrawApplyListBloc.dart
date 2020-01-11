import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class WithdrawApplyListBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<WithdrawListResponse> _subject =
	BehaviorSubject<WithdrawListResponse>();

	void withdrawApply() async {
		WithdrawListResponse response = await _repository.withdrawApply();
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<WithdrawListResponse> get subject => _subject;
}