import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/bloc/profile/profile_bloc.dart';
import 'package:smartmarktclient/models/basket_history.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/views/profile/history/empty_history_screen.dart';
import 'package:smartmarktclient/views/profile/history/history_position.dart';

class HistoryComponent extends StatefulWidget {
  @override
  _HistoryComponentState createState() => _HistoryComponentState();
}

class _HistoryComponentState extends State<HistoryComponent> {
  ProfileBloc _profileBloc;

  List<BasketHistory> get basketProducts => _profileBloc.basketHistory;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return _shoppingHistoryList();
  }

  Widget _shoppingHistoryList() {
    if (basketProducts == null || basketProducts.isEmpty) {
      return EmptyHistoryScreen();
    }
    return _historyList();
  }

  Widget _historyList() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 3),
        color: complementaryThree.withOpacity(0.7),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 70),
          itemCount: basketProducts != null ? basketProducts.length : 0,
          itemBuilder: (_, index) {
            return HistoryPosition(index: index);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _profileBloc.close();
  }
}
