import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/bloc/profile/profile_bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';

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
          create: (_) => _profileBloc,
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              setState(() {});
            },
            child: Container(),
          ),
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
