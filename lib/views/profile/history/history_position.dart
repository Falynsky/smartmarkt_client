import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/bloc/profile/profile_bloc.dart';
import 'package:smartmarktclient/models/basket_history.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class HistoryPosition extends StatefulWidget {
  final int index;

  const HistoryPosition({required this.index});

  @override
  _HistoryPositionState createState() => _HistoryPositionState();
}

class _HistoryPositionState extends State<HistoryPosition> {
 late ProfileBloc _profileBloc;
 late int _index;
 late String _purchasedDate;
 late String _productSummary;

  List<BasketHistory> get basketProducts => _profileBloc.basketHistory;

  BasketHistory get basketHistory => basketProducts[_index];

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _index = widget.index;
    _purchasedDate = basketHistory.purchasedDateTime;
    _productSummary = basketHistory.purchasedPriceSummary.toString();
  }

  @override
  Widget build(BuildContext context) {
    return listCard();
  }

  Widget listCard() {
    return Card(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_purchasedDate),
              Text("$_productSummary zł"),
            ],
          ),
        ),
        onTap: () => {
          _profileBloc.add(
            ShowBasketHistoryDialogEvent(
              basketHistoryId: basketHistory.id,
              purchasedDate: _purchasedDate,
              productSummary: _productSummary,
            ),
          )
        },
        splashFactory: InkSplash.splashFactory,
        splashColor: secondaryColor,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _profileBloc.close();
  }
}
