import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class WithdrawAddressListBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<WithdrawAddressListResponse> _subject =
	BehaviorSubject<WithdrawAddressListResponse>();

	void getWithdrawAddress() async {
		WithdrawAddressListResponse response = await _repository.getWithdrawAddress();
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<WithdrawAddressListResponse> get subject => _subject;
}