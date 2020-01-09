import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class PlaceOrderBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<PlaceOrderResponse> _subject =
	BehaviorSubject<PlaceOrderResponse>();
	void placeOrder(int amount) async {
		PlaceOrderResponse response = await _repository.placeOrder(amount);
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<PlaceOrderResponse> get subject => _subject;
}