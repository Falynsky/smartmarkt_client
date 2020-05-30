import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/items_page.dart';
import 'package:smartmarktclient/main_page.dart';

class RouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RouteBloc, RouteState>(
      listener: (context, state) {},
      child: BlocBuilder<RouteBloc, RouteState>(
        builder: (context, state) {
          if (state is InitialRouteState) {
            return MainPage();
          } else if (state is ItemsState) {
            return ItemsPage();
          } else {
            return MainPage();
          }
        },
      ),
    );
  }
}
