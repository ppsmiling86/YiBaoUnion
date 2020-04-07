import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/models/WithdrawAddressListBloc.dart';
import 'package:myapp/models/Response.dart';
import 'package:myapp/tools/stringTools.dart';
import 'package:myapp/models/ApiRepository.dart';
class ManageAddressView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return ManageAddressViewState();
	}
}

class ManageAddressViewState extends State<ManageAddressView> {
	final _apiRepository = ApiRepository();
	final editAddressController = TextEditingController();
	final editTagController = TextEditingController();
	final _formKey = GlobalKey<FormState>();
	var isEditingMode = false;
	final listBloc = WithdrawAddressListBloc();
	@override
	void dispose() {
		super.dispose();
		editAddressController.dispose();
		editTagController.dispose();
		listBloc.dispose();
	}

	@override
	Widget build(BuildContext context) {
		listBloc.getWithdrawAddress();
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
							child: Center(child: isEditingMode ? Text("完成",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor)) :
							Text("编辑",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))),
						),
					),
				),
			]),
			body: buildStreamBuilderView(),
			bottomNavigationBar: CommonWidgetTools.buildBottomButton(context,"新增", (){

				showDialog(
					context: context,
					builder: (BuildContext context){
						return buildEditAddressDialog(WithdrawAddressEntity(" "," "," "));
					}
				);
			}),
		);
	}

	StreamBuilder buildStreamBuilderView() {
		return StreamBuilder<WithdrawAddressListResponse>(
			stream: listBloc.subject.stream,
			builder: (context, AsyncSnapshot<WithdrawAddressListResponse> snapshot) {
				print(snapshot);
				if (snapshot.hasData) {
					return SizedBox(
						width: double.infinity,
						child: Container(
							padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
							child: buildListData(snapshot),
						),
					);
				} else if (snapshot.hasError) {
					print("hasError");
					return Container();
				} else {
					print("loading");
					return SizedBox(
						width: double.infinity,
						height: 100,
						child: Container(
							child: Center(child: CircularProgressIndicator()),
						),
					);
				}
			});
	}
	
	Widget buildListData(AsyncSnapshot<WithdrawAddressListResponse> snapshot) {
		if (snapshot.data.data is List) {
			if (snapshot.data.data.length > 0) {
				return ListView.separated(
					itemBuilder: (contest,index) => Padding(
					  padding:  EdgeInsets.symmetric(vertical: 10),
					  child: buildAddressItem(snapshot.data.data[index]),
					),
					separatorBuilder: (context, index) => Divider(thickness: 1),
					itemCount: snapshot.data.data.length,
				);
			}
		}
		return CommonWidgetTools.buildEmptyListPlaceholder(context);
	}

	Widget buildAddressItem(WithdrawAddressEntity withdrawAddressEntity) {
		List<Widget>list = []..add(Expanded(
			flex: 3,
			child: buildListColumn("备注", withdrawAddressEntity.tag)));
		list.add(Expanded(
			flex: 3,
			child: buildListColumn("地址", withdrawAddressEntity.address)));
		if (isEditingMode) {
			list.add(Expanded(
				flex: 2,
				child: buildEditAndDelete(withdrawAddressEntity)));
		}
		return Container(
			child: Row(
				mainAxisAlignment: MainAxisAlignment.start,
				children: list,
			),
		);
	}

	Widget buildEditAndDelete(WithdrawAddressEntity withdrawAddressEntity) {
		return Row(
			children: <Widget>[
				IconButton(icon: Icon(Icons.edit,color: Theme.of(context).primaryColor), onPressed: (){
					showDialog(
						context: context,
						builder: (BuildContext context){
							return buildEditAddressDialog(withdrawAddressEntity);
						}
					);
				}),
				IconButton(icon: Icon(Icons.delete,color: Theme.of(context).errorColor), onPressed: (){
					CommonWidgetTools.showConfirmAlertController(context, "确认删除？", (){
						CommonWidgetTools.showLoading(context);
						_apiRepository.deleteWithdrawAddress(withdrawAddressEntity).then((value){
							CommonWidgetTools.dismissLoading(context);
							if (value.code != "0") {
								CommonWidgetTools.showToastView(context, "删除失败");
							} else {
								CommonWidgetTools.showToastView(context,"删除成功");
								setState(() {
								});
							}
						});
					});
				}),
			],
		);
	}

	Widget buildListColumn(String title, String value) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: <Widget>[
				Text(title,style: Theme.of(context).textTheme.caption),
				SizedBox(height: 10),
				Text(value,style: Theme.of(context).textTheme.bodyText1),
			],
		);
	}

	Widget buildEditAddressDialog(WithdrawAddressEntity withdrawAddressEntity) {
		editTagController.text = withdrawAddressEntity.tag;
		editAddressController.text = withdrawAddressEntity.address;
		return AlertDialog(
			content: SizedBox(
				width: 300,
				height: 200,
				child: Container(
					child: Form(
						key: _formKey,
						child: Column(
							children: <Widget>[
								TextFormField(
									controller: editTagController,
									decoration: InputDecoration(
										icon: Icon(Icons.bookmark),
										labelText: '备注:',
										hintText: "请输入备注"
									),
									validator: (String value) {
										if (value.isEmpty) {
											return '请输入备注';
										}
										return null;
									},
								),
								TextFormField(
									controller: editAddressController,
									decoration: InputDecoration(
										icon: Icon(Icons.account_balance_wallet),
										labelText: '共创钱包地址:',
										hintText: "请输入或长按粘贴地址"
									),
									validator: (String value) {
										if (!StringTools.ValidateWithdrawAddress(value.trim())) {
											return '请输入正确的提币地址';
										}
										return null;
									},
								)
							],
						),
					),
				),
			),
			actions: <Widget>[
				OutlineButton(
					shape: StadiumBorder(),
					borderSide: BorderSide(color: Theme.of(context).buttonColor),
					onPressed: (){
					Navigator.pop(context);
				}, child: Text("取消",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).buttonColor))),
				FlatButton(
					color: Theme.of(context).buttonColor,
					shape: StadiumBorder(),
					onPressed: (){
					if (_formKey.currentState.validate()) {
						CommonWidgetTools.showLoading(context);
						bool isEditAddress = withdrawAddressEntity.id.length > 1;
						if (isEditAddress) {
							print("edit address");
							_apiRepository.editWithdrawAddress(WithdrawAddressEntity(withdrawAddressEntity.id, editTagController.text.trim(), editAddressController.text.trim())).then((value){
								CommonWidgetTools.dismissLoading(context);
								if (value.data == null) {
									CommonWidgetTools.showToastView(context, "编辑失败");
								} else {
									CommonWidgetTools.showToastView(context,"编辑成功");
									setState(() {
										Navigator.pop(context);
									});
								}
							});
						} else {
							print("add address");
							_apiRepository.addWithdrawAddress(WithdrawAddressEntity("", editTagController.text.trim(), editAddressController.text.trim())).then((value){
								CommonWidgetTools.dismissLoading(context);
								if (value.data == null) {
									CommonWidgetTools.showToastView(context, "添加失败");
								} else {
									CommonWidgetTools.showToastView(context, "添加成功");
									setState(() {
										Navigator.pop(context);
									});
								}
							});
						}
					}
				}, child: Text("确认",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))),
			],
		);
	}

}

