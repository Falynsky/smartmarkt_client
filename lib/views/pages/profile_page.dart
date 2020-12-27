import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/http/http_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  RouteBloc _routeBloc;

  @override
  void initState() {
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _routeBloc.add(LoadMainMenuEvent());
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: PagesAppBar(title: "Profil"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 60, right: 60, top: 50),
                child: Row(
                  children: <Widget>[
                    _logoutButton(),
                    Spacer(),
                    _pointsButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return Column(
      children: <Widget>[
        IconButton(
          iconSize: 60,
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            HttpService.clearAuthHeader();
            _routeBloc.add(LoadLoginPageEvent());
          },
        ),
        Text("Wyloguj", style: TextStyle(fontSize: 20))
      ],
    );
  }

  Widget _pointsButton() {
    return Column(
      children: <Widget>[
        IconButton(
          iconSize: 60,
          icon: Icon(Icons.account_balance_wallet),
          onPressed: () {
            print("pressed points button");
          },
        ),
        Text("Moje punkty", style: TextStyle(fontSize: 20))
      ],
    );
  }
}
