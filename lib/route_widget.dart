import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/views/pages/login_page.dart';
import 'package:smartmarktclient/views/pages/products/products_panel.dart';

import 'views/pages/basket_page.dart';
import 'views/pages/main_page.dart';
import 'views/pages/profile_page.dart';
import 'views/pages/sales_page.dart';
import 'views/pages/scanner_page.dart';
import 'views/pages/settings_page.dart';

class RouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RouteBloc, RouteState>(
      listener: (context, state) {},
      child: BlocBuilder<RouteBloc, RouteState>(
        builder: (context, state) {
          if (state is InitialRouteState || state is LoginPageState) {
            return LoginPage();
          } else if (state is MainMenuState) {
            return MainPage();
          } else if (state is ProductsPanelState) {
            return ProductsPanel();
          } else if (state is ScannerState) {
            return ScannerPage();
          } else if (state is SalesState) {
            return SalesPage();
          } else if (state is BasketState) {
            return BasketPage();
          } else if (state is ProfileState) {
            return ProfilePage();
          } else if (state is SettingsState) {
            return SettingsPage();
          } else {
            return Container(color: Colors.red);
          }
        },
      ),
    );
  }
}
