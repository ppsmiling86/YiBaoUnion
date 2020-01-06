import 'Response.dart';
import 'ApiRepository.dart';
import 'package:rxdart/rxdart.dart';

class CatalogsBloc {
	final ApiRepository _repository = ApiRepository();
	final BehaviorSubject<CatalogResponse> _subject =
	BehaviorSubject<CatalogResponse>();
	void getCatalogs() async {
		print("start get catalogs");
		CatalogResponse response = await _repository.getCatalogs();
		_subject.sink.add(response);
	}

	void dispose() {
		_subject.close();
	}

	BehaviorSubject<CatalogResponse> get subject => _subject;
}