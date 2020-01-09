import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/common_widget_tools.dart';
class ManageAddressView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return ManageAddressViewState();
	}
}

class ManageAddressViewState extends State<ManageAddressView> {
	var isEditingMode = false;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitleActions(context, "管理地址", [
				GestureDetector(
					onTap: (){
						setState(() {
						  isEditingMode = !isEditingMode;
						});
					},
					child: SizedBox(
						width: 80,
						child: Container(
							child: Center(child: isEditingMode ? Text("完成") : Text("编辑")),
						),
					),
				),
			]),
			body: SizedBox(
				width: double.infinity,
				child: Container(
					padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
					child: ListView.separated(
						itemBuilder: (contest,index) => buildAddressItem(MockAddress()),
						separatorBuilder: (context, index) => Divider(),
						itemCount: 2,
					),
				),
			),
			bottomNavigationBar: CommonWidgetTools.buildBottomButton("新增", (){
				showDialog(
					context: context,
					builder: (BuildContext context){
						return buildEditAddressDialog(MockAddress());
					}
				);
			}),
		);
	}

	Widget buildAddressItem(AddressInterface address) {
		List<Widget>list = []..add(Expanded(
			flex: 3,
			child: buildListColumn("备注", address.remark())));
		list.add(Expanded(
			flex: 3,
			child: buildListColumn("地址", address.address())));
		if (isEditingMode) {
			list.add(Expanded(
				flex: 2,
				child: buildEditAndDelete()));
		}
		return Container(
			child: Row(
				mainAxisAlignment: MainAxisAlignment.start,
				children: list,
			),
		);
	}

	Widget buildEditAndDelete() {
		return Row(
			children: <Widget>[
				IconButton(icon: Icon(Icons.edit), onPressed: (){
					showDialog(
						context: context,
						builder: (BuildContext context){
							return buildEditAddressDialog(MockAddress());
						}
					);
				}),
				IconButton(icon: Icon(Icons.delete), onPressed: (){

				}),
			],
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
	
	Widget buildEditAddressDialog(AddressInterface address) {
		return AlertDialog(
			content: SizedBox(
				width: 300,
				height: 200,
				child: Container(
					child: Column(
						children: <Widget>[
							TextFormField(
								initialValue: address.remark(),
								decoration: InputDecoration(
									icon: Icon(Icons.bookmark),
									labelText: '备注:',
									hintText: "请输入备注"
								),
								onSaved: (String value) {
								},
								validator: (String value) {
									if (value.isEmpty) {
										return '请输入备注';
									}
									return null;
								},
							),
							TextFormField(
								initialValue: address.address(),
								decoration: InputDecoration(
									icon: Icon(Icons.account_balance_wallet),
									labelText: '共创钱包地址:',
									hintText: "请输入或长按粘贴地址"
								),
								onSaved: (String value) {
								},
								validator: (String value) {
									if (value.isEmpty) {
										return '请输入提币地址';
									}
									return null;
								},
							)
						],
					),
				),
			),
			actions: <Widget>[
				FlatButton(onPressed: (){
					Navigator.pop(context);
				}, child: Text("取消")),
				FlatButton(onPressed: (){
					Navigator.pop(context);
				}, child: Text("确认")),
			],
		);
	}

}

abstract class AddressInterface {
	String remark();
	String address();
}

class MockAddress implements AddressInterface {
	@override
	String remark() {
		return "我的提现地址";
	}
	@override
	String address() {
		return "xxxxxxxxxx";
	}
}

