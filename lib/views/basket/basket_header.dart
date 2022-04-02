import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class BasketHeader extends StatefulWidget {
  @override
  _BasketHeaderState createState() => _BasketHeaderState();
}

class _BasketHeaderState extends State<BasketHeader> {
  late BasketBloc _basketBloc;

  @override
  void initState() {
    super.initState();
    _basketBloc = BlocProvider.of<BasketBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return _basketSummary();
  }

  Widget _basketSummary() {
    final summaryAfterDiscount = _basketBloc.summaryAfterDiscount;
    final basketSummary = _basketBloc.basketSummary;
    var basketWithDiscount = summaryAfterDiscount < basketSummary;
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 8, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _summaryTitle(),
              basketWithDiscount ? _regularSummaryCrossed() : _regularSummary(),
              SizedBox(width: 10),
              if (basketWithDiscount) _discountSummary(),
            ],
          ),
          _clearBasketTopButton()
        ],
      ),
    );
  }

  Widget _regularSummary() {
    return Text(
      "${_basketBloc.summaryAfterDiscount}zł ",
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 15,
      ),
    );
  }

  Widget _regularSummaryCrossed() {
    return Text(
      "${_basketBloc.basketSummary}zł ",
      style: TextStyle(
        decoration: TextDecoration.lineThrough,
        decorationColor: Colors.red,
        decorationThickness: 2,
        fontWeight: FontWeight.w800,
        fontSize: 15,
      ),
    );
  }

  Widget _discountSummary() {
    return Text(
      "${_basketBloc.summaryAfterDiscount}zł",
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 15,
      ),
    );
  }

  Widget _clearBasketTopButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(25.0),
      splashFactory: InkRipple.splashFactory,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.remove_shopping_cart_rounded),
      ),
      onTap: () => _showRemoveButtonDialog(
        event: ClearBasketEvent(),
        info: "Czy na pewno chcesz wyczyścić koszyk?",
      ),
    );
  }

  Text _summaryTitle() {
    return Text(
      "Wartość koszyka: ",
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 15,
      ),
    );
  }

  Future<void> _showRemoveButtonDialog({
    required BasketEvent event,
    required String info,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
          ),
          child: AlertDialog(
            backgroundColor: shadesThree,
            title: Text("Uwaga!"),
            titleTextStyle: TextStyle(color: complementaryThree, fontSize: 20),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(info),
                ],
              ),
            ),
            contentTextStyle: TextStyle(color: Colors.white70, fontSize: 16),
            actions: <Widget>[
              TextButton(
                child: Text('Nie', style: TextStyle(color: complementaryThree)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Tak', style: TextStyle(color: complementaryThree)),
                onPressed: () {
                  _basketBloc.add(event);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
