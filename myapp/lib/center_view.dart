import 'package:flutter/cupertino.dart';
import 'imageTools.dart';

class CenterView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return CenterViewState();
	}
}

class CenterViewState extends State <CenterView> {
	@override
	Widget build(BuildContext context) {
		var width = MediaQuery.of(context).size.width - 32;
		return ListView(
			children: <Widget>[
				Image(
					width: width,
					fit: BoxFit.fill,
					image: AssetImage(ImageTools.placeholder1)
				),
				Image(
					width: width,
					fit: BoxFit.fill,
					image: AssetImage(ImageTools.placeholder2)
				),
				Image(
					width: width,
					fit: BoxFit.fill,
					image: AssetImage(ImageTools.placeholder3)
				),
			],
		);
	}
}