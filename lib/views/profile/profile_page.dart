import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/bloc/profile/history/history_details_page.dart';
import 'package:smartmarktclient/bloc/profile/profile_bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/models/product_history.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/views/profile/history/history_component.dart';
import 'package:smartmarktclient/views/profile/history/history_header.dart';
import 'package:smartmarktclient/views/profile/profile_avatar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  RouteBloc _routeBloc;
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _profileBloc = ProfileBloc();
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
        body: BlocProvider(
          create: (_) => _profileBloc..add(InitialProfileEvent()),
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is LoadProfileScreenState) {
              } else if (state is ShowBasketHistoryDialogState) {
                _showOverlay(
                  context,
                  state.productsList,
                  state.purchasedDate,
                  state.productSummary,
                );
              }
              setState(() {});
            },
            child: _buildProfilePage(),
          ),
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  Widget _buildProfilePage() {
    return Column(
      children: [
        ProfileAvatar(),
        Divider(height: 0, thickness: 2),
        HistoryHeader(),
        Divider(height: 0, thickness: 2),
        HistoryComponent()
      ],
    );
  }

  void _showOverlay(
    BuildContext context,
    List<ProductHistory> productsList,
    String purchasedDate,
    String productSummary,
  ) {
    Navigator.of(context).push(
      new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return HistoryDetailsPage(
            purchasedDate: purchasedDate,
            productsList: productsList,
            productSummary: productSummary,
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _profileBloc.close();
  }
}
