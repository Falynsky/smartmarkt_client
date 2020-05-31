import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _routeBloc.add(MainMenuEvent());
                  });
                },
              ),
              SizedBox(width: 20),
              Text("Profile"),
            ],
          ),
        ),
        elevation: .1,
        backgroundColor: Colors.black45,
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
    );
  }

  Widget _logoutButton() {
    return Column(
      children: <Widget>[
        IconButton(
          iconSize: 60,
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            setState(() {
              _routeBloc.add(LoginPageEvent());
            });
          },
        ),
        Text(
          "Log Out",
          style: TextStyle(fontSize: 20),
        )
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
        Text(
          "My Points",
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
