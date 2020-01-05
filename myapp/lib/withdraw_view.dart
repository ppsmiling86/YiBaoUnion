import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AppData.dart';


class WithdrawView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return WithdrawViewState();
	}
}

class WithdrawViewState extends State<WithdrawView> {
	List<WithdrawRecord> withdrawDataList = [
		WithdrawRecord(1000, "2020.2.22", WithdrawStatus.processing),
		WithdrawRecord(1000, "2020.2.22", WithdrawStatus.succeed),
		WithdrawRecord(1000, "2020.2.22", WithdrawStatus.failed),
	];
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: (){
					Navigator.of(context).pop();
				}),
				title: Text("提现记录"),
				centerTitle: true,
			),
			body: ListView.builder(
				itemCount: withdrawDataList.length,
				itemBuilder: (context, index) {
				return buildWithdrawRecord(withdrawDataList[index]);
			}),
		);
	}

	Widget buildWithdrawRecord(WithdrawRecord record) {
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
			height: 100,
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					Expanded(
						flex: 1,
						child: Column(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								Text("共创积分: ${record.credits}"),
								Text(record.dateTime),
							],
						),
					),
					Expanded(
						flex: 1,
						child: Container(
							height: 60,
							child: Center(child: Text(record.buildStatusStr()))
						),
					),
				],
			),
		);
	}
}