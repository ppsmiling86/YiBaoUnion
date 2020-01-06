import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/AppData.dart';


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
			appBar: AppBar(
				leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: (){
					Navigator.of(context).pop();
				}),
				title: Text("提现记录"),
				centerTitle: true,
			),
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
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: <Widget>[
						Expanded(
							flex: 1,
							child: SizedBox(
								height: 50,
								child: Column(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									crossAxisAlignment: CrossAxisAlignment.start,
									children: <Widget>[
										Text("共创积分: ${record.credits}"),
										Text(record.dateTime),
									],
								),
							),
						),
						Expanded(
							flex: 1,
							child: SizedBox(
								height: 50,
								child: Container(
									child: Center(child: Text(record.buildStatusStr()))
								),
							),
						),
					],
				),
			)

//		  Container(
//		  	height: 99,
//		  	child: Row(
//		  		mainAxisAlignment: MainAxisAlignment.spaceBetween,
//		  		children: <Widget>[
//		  			Expanded(
//		  				flex: 1,
//		  				child: Column(
//		  					mainAxisAlignment: MainAxisAlignment.spaceBetween,
//		  					crossAxisAlignment: CrossAxisAlignment.start,
//		  					children: <Widget>[
//		  						Text("共创积分: ${record.credits}"),
//		  						Text(record.dateTime),
//		  					],
//		  				),
//		  			),
//		  			Expanded(
//		  				flex: 1,
//		  				child: Container(
//		  					height: 60,
//		  					child: Center(child: Text(record.buildStatusStr()))
//		  				),
//		  			),
//		  		],
//		  	),
//		  ),
		);
	}
}