import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/views/main/card/dashboard_card.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  RouteBloc _routeBloc;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showLogoutDialog();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black87,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("SmartMarkt"),
              Row(
                children: [
                  InkWell(
                    child: Icon(Icons.person),
                    onTap: () => _emitProfileScreen(),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    child: Icon(Icons.logout),
                    onTap: () => _showLogoutDialog(),
                  ),
                ],
              )
            ],
          ),
          elevation: 6,
          backgroundColor: analogThree,
        ),
        body: Container(
          color: primaryColor,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: GridView.builder(
              itemCount: gridViewData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.height / 360,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: DashboardCard(
                    label: gridViewData[index]['label'],
                    iconData: gridViewData[index]['iconData'],
                    pageIdn: gridViewData[index]['pageIdn'],
                  ),
                );
              }),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: shadesThree,
          titleTextStyle: TextStyle(color: complementaryThree, fontSize: 20),
          title: Text("Wylogowanie"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Czy na pewno chcesz się wylogować?"),
              ],
            ),
          ),
          contentTextStyle: TextStyle(color: Colors.white70, fontSize: 16),
          actions: <Widget>[
            _noButton(context),
            _yesButton(context),
          ],
        );
      },
    );
  }

  FlatButton _yesButton(BuildContext context) {
    return FlatButton(
      child: Text("Tak"),
      textColor: complementaryThree,
      onPressed: () {
        HttpService.clearAuthHeader();
        _routeBloc.add(LoadLoginPageEvent());
        Navigator.of(context).pop();
      },
    );
  }

  FlatButton _noButton(BuildContext context) {
    return FlatButton(
      child: Text("Nie"),
      textColor: complementaryThree,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  List<Map<String, dynamic>> gridViewData = [
    {'label': 'SKANER', 'iconData': Icons.scanner, 'pageIdn': 'scanner'},
    {'label': 'PRODUKTY', 'iconData': Icons.fastfood, 'pageIdn': 'products'},
    {'label': 'PROMOCJE', 'iconData': Icons.alarm, 'pageIdn': 'sales'},
    {'label': 'KOSZYK', 'iconData': Icons.shopping_basket, 'pageIdn': 'basket'},
  ];

  void _emitProfileScreen() {
    _routeBloc.add(LoadProfilePageEvent());
  }
}
