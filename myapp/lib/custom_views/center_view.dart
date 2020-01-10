import 'package:flutter/cupertino.dart';
import 'package:myapp/tools/imageTools.dart';

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
		List<String>images = [];
		images.add(ImageTools.placeholder1);
		images.add(ImageTools.placeholder2);
		images.add(ImageTools.placeholder3);
		images.add(ImageTools.placeholder4);
		images.add(ImageTools.placeholder5);
		images.add(ImageTools.placeholder6);
		return ListView.builder(
			itemCount: images.length,
			itemBuilder: (context,index) => buildImage(images[index], width),
		);
	}

	Widget buildImage(String imgStr, double width) {
		return Image(
			width: width,
			fit: BoxFit.fill,
			image: AssetImage(imgStr)
		);
	}
}