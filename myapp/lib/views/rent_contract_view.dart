import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/common_widget_tools.dart';


class RentContractView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return RentContractViewState();
	}
}

class RentContractViewState extends State <RentContractView> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitle(context, "算力租赁服务条款"),
			body: buildRentContractView(),
		);
	}

	Widget buildRentContractView() {
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 16),
			height: 200,
			width: MediaQuery.of(context).size.width - 32,
			child: Text("一、算力租赁服务协议的确认\n"
				+ "请您先仔细阅读本协议内容，充分理解本协议及各条款。如果您对本协议内容有任何疑问，请勿进行下一步操作。您可通过官方在线客服进行咨询，以便我们为您解释和说明。您通过页面点击或其他方式确认即表示您已同意本协议。"
				+ "\n如我们对本协议进行修改，我们将通过网站公告的方式提前予以公布。\n"
				+ "您确认：a）您年满18周岁并具有完全民事行为能力。b）您接受并使用我们提供的服务在您的居住地/\n"
				+ "国家符合适用法律法规和相关政策，且不违反您对于任何其他第三方的义务。\n"
				+ "您发现当由于事实或法律法规变化您无法承诺本条a和/或b款规定的内容时，您会立即停止"
					"使用比特算力提供的服务并通过客服务渠道告知比特算力停止服务。终止服务后，您使用比特算力服务的权利立即终止。"
					"您同意：在这种情况下，比特算力没有义务将任何未处理的信息或未完成的服务传输给您或任何第三方。"
			),
		);
	}
}