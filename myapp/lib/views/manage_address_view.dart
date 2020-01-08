import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageAddressView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return ManageAddressViewState();
	}
}

class ManageAddressViewState extends State<ManageAddressView> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: (){
					Navigator.of(context).pop();
				}),
				title: Text("管理地址"),
				centerTitle: true,
			),
			body: SizedBox(
				width: double.infinity,
				child: Container(
					padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
					child: ListView.separated(
						itemBuilder: (contest,index) => buildAddressItem(),
						separatorBuilder: (context, index) => Divider(),
						itemCount: 2,
					),
				),
			),
		);
	}

	Widget buildAddressItem() {
		return Container(
			child: Row(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[
					Expanded(
						flex: 1,
						child: buildListColumn("备注", "我的提现地址")),
					Expanded(
						flex: 1,
						child: buildListColumn("地址", "xxxxxxxxxxxx")),
				],
			),
		);
	}

	Widget buildListColumn(String title, String value) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: <Widget>[
				Text(title),
				Text(value,style: TextStyle(color: Colors.grey)),
			],
		);
	}

}
