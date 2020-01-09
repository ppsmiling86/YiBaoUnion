import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/AppData.dart';
import 'package:myapp/tools/common_widget_tools.dart';

class WithdrawHistoryView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return WithdrawHistoryViewState();
	}
}

class WithdrawHistoryViewState extends State<WithdrawHistoryView> {
	List<WithdrawRecord> withdrawDataList = [
		WithdrawRecord(1000, "2020.2.22", WithdrawStatus.processing),
		WithdrawRecord(1000, "2020.2.22", WithdrawStatus.succeed),
		WithdrawRecord(1000, "2020.2.22", WithdrawStatus.failed),
	];
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitle(context, "提现记录"),
			body: ListView.separated(
				itemBuilder: (contest,index) => buildWithdrawRecord(withdrawDataList[index]),
				separatorBuilder: (context, index) => Divider(color: Colors.black),
				itemCount: withdrawDataList.length,
			)
		);
	}

	Widget buildWithdrawRecord(WithdrawRecord record) {
		return SizedBox(
			width: double.infinity,
			height: 90,
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Expanded(
									flex: 1,
									child: SizedBox(
										height: 40,
										child: Column(
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
												Text("提现积分"),
												Text("1000"),
											],
										),
									),
								),
								Expanded(
									flex: 1,
									child: SizedBox(
										height: 40,
										child: Column(
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
												Text("提现地址"),
												Text("xxxxxxxxxxxx"),
											],
										),
									),
								),
								Expanded(
									flex: 1,
									child: SizedBox(
										height: 40,
										child: Container(
											child: Center(child: Text(record.buildStatusStr()))
										),
									),
								),
							],
						),
						SizedBox(height: 16),
						Text("2020.2.22 10:10:10"),
					],
				),
			)
		);
	}
}