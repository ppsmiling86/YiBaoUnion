import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/AppData.dart';
import 'package:myapp/tools/colorTools.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/models/WithdrawApplyListBloc.dart';
import 'package:myapp/models/Response.dart';
import 'package:myapp/tools/dateTools.dart';

class WithdrawHistoryView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return WithdrawHistoryViewState();
	}
}

class WithdrawHistoryViewState extends State<WithdrawHistoryView> {
	final listBloc = WithdrawApplyListBloc();
	@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
	listBloc.dispose();
  }

	@override
	Widget build(BuildContext context) {
		listBloc.withdrawApply();
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitle(context, "提现记录"),
			body:buildWithdrawListStreamBuilderView(),
		);
	}

	StreamBuilder buildWithdrawListStreamBuilderView() {
		return StreamBuilder<WithdrawListResponse>(
			stream: listBloc.subject.stream,
			builder: (context, AsyncSnapshot<WithdrawListResponse> snapshot) {
				print(snapshot);
				if (snapshot.hasData) {
					return buildListData(snapshot);
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

	Widget buildListData(AsyncSnapshot<WithdrawListResponse> snapshot) {
		if (snapshot.data.data.length > 0) {
			return ListView.separated(
				itemBuilder: (contest,index) => buildWithdrawRecord(snapshot.data.data[index]),
				separatorBuilder: (context, index) => Divider(color: ColorTools.greyA1A6B3),
				itemCount: snapshot.data.data.length,
			);
		}
		return CommonWidgetTools.buildEmptyListPlaceholder(context);
	}

	Widget buildWithdrawRecord(WithdrawEntity withdrawEntity) {
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
												Text("提现积分",style: Theme.of(context).textTheme.subtitle1),
												Text("${withdrawEntity.value}",style: Theme.of(context).textTheme.bodyText2),
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
												Text("提现地址",style: Theme.of(context).textTheme.subtitle1),
												Text("${withdrawEntity.address}",style: Theme.of(context).textTheme.bodyText2),
											],
										),
									),
								),
								Expanded(
									flex: 1,
									child: SizedBox(
										height: 40,
										child: Container(
											child: Center(child: Text(withdrawEntity.buildStatusStr(),style: Theme.of(context).textTheme.bodyText2))
										),
									),
								),
							],
						),
						SizedBox(height: 16),
						Text("${DateTools.ConvertDateToString(withdrawEntity.created_at)}",style: Theme.of(context).textTheme.bodyText2),
					],
				),
			)
		);
	}
}