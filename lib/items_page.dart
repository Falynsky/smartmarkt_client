import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("DASHBOARD"),
        ),
        elevation: .1,
        backgroundColor: Colors.black45,
      ),
      body: Container(
          color: Colors.amber,
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      RouteBloc routeBloc = BlocProvider.of<RouteBloc>(context);
                      routeBloc.add(MainMenuEvent());
                    });
                  },
                ),
                title: Text("back"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_forward),
                title: Text("next"),
              )
            ],
          )),
    );
  }

/*  setState(() {
  RouteBloc routeBloc = BlocProvider.of<RouteBloc>(context);
  routeBloc.add(MainMenuEvent());
  });*/
}
