import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/bloc/profile/history/history_details_page.dart';
import 'package:smartmarktclient/bloc/profile/profile_bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/utilities/colors.dart';

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
                _showOverlay(context);
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
        _circleAvatar(),
        Divider(height: 0, thickness: 2),
        _historyListHeader(),
        Divider(height: 0, thickness: 2),
        _shoppingHistoryList()
      ],
    );
  }

  Padding _circleAvatar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 65,
            child: Text(
              _profileBloc.initials ?? '',
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 10),
          Text(
            _profileBloc.name ?? '',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Container _historyListHeader() {
    return Container(
      color: shadesTwo,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Historia zakupów",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: complementaryTwo,
            ),
          ),
        ],
      ),
    );
  }

  Expanded _shoppingHistoryList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 70),
        itemCount: _profileBloc.basketHistory != null
            ? _profileBloc.basketHistory.length
            : 0,
        itemBuilder: (context, index) {
          return listCard(context, index);
        },
      ),
    );
  }

  Widget listCard(BuildContext context, int index) {
    Map<String, dynamic> basketHistory = _profileBloc.basketHistory[index];
    return Card(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(basketHistory["purchasedDateTime"]),
              Text("${basketHistory["purchasedPriceSummary"]} zł"),
            ],
          ),
        ),
        onTap: () => {_profileBloc.add(ShowBasketHistoryDialogEvent())},
        splashFactory: InkSplash.splashFactory,
        splashColor: secondaryColor,
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(
      new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return HistoryDetailsPage();
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
