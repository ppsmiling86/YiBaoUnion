import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class WithdrawAddressBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<WithdrawAddressResponse> _subject =
	BehaviorSubject<WithdrawAddressResponse>();


	void addWithdrawAddress(WithdrawAddressEntity withdrawAddressEntity) async {
		WithdrawAddressResponse response = await _repository.addWithdrawAddress(withdrawAddressEntity);
		_subject.sink.add(response);
	}

	void deleteWithdrawAddress(WithdrawAddressEntity withdrawAddressEntity) async {
		WithdrawAddressResponse response = await _repository.deleteWithdrawAddress(withdrawAddressEntity);
		_subject.sink.add(response);
	}

	void editWithdrawAddress(WithdrawAddressEntity withdrawAddressEntity) async {
		WithdrawAddressResponse response = await _repository.editWithdrawAddress(withdrawAddressEntity);
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<WithdrawAddressResponse> get subject => _subject;
}