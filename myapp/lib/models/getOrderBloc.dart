import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class GetOrderBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<GetOrderResponse> _subject =
	BehaviorSubject<GetOrderResponse>();
	void getOrder() async {
		GetOrderResponse response = await _repository.getOrder();
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<GetOrderResponse> get subject => _subject;
}