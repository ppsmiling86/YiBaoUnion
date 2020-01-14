import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class ContractView extends StatefulWidget {
	@override
	ContractViewState createState() {
		return ContractViewState();
	}
}

class ContractViewState extends State<ContractView> {
	WebViewController _controller;

	@override
	Widget build(BuildContext context) {
		_loadHtmlFromAssets();
		return Scaffold(
			appBar: AppBar(title: Text('租赁协议')),
			body: WebviewScaffold(url: null)
		);
	}

	_loadHtmlFromAssets() async {
		String fileText = await rootBundle.loadString(ImageTools.contract);
		print("filtest is ${fileText}");
		_controller.loadUrl( Uri.dataFromString(
			fileText,
			mimeType: 'text/html',
			encoding: Encoding.getByName('utf-8')
		).toString());
	}
}