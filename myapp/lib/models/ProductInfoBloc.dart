import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class ProductInfoBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<ProductResponse> _subject =
	BehaviorSubject<ProductResponse>();
	void productInfo() async {
		ProductResponse response = await _repository.productInfo();
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<ProductResponse> get subject => _subject;
}