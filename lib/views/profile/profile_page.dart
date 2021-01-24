import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/bloc/profile/history/history_details_page.dart';
import 'package:smartmarktclient/bloc/profile/profile_bloc.dart';
import 'package:smartmarktclient/components/pages_app_bar.dart';
import 'package:smartmarktclient/models/basket_history.dart';
import 'package:smartmarktclient/models/product_history.dart';
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
            backgroundColor: complementaryThree,
            radius: 65,
            child: Text(
              _profileBloc.initials ?? '',
              style: TextStyle(fontSize: 55),
            ),
          ),
          SizedBox(height: 10),
          Text(
            _profileBloc.name ?? '',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
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
      child: Container(
        padding: EdgeInsets.only(top: 3),
        color: complementaryThree.withOpacity(0.7),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 70),
          itemCount: _profileBloc.basketHistory != null
              ? _profileBloc.basketHistory.length
              : 0,
          itemBuilder: (context, index) {
            return listCard(context, index);
          },
        ),
      ),
    );
  }

  Widget listCard(BuildContext context, int index) {
    BasketHistory basketHistory = _profileBloc.basketHistory[index];
    String _purchasedDate = basketHistory.purchasedDateTime;
    String _productSummary = basketHistory.purchasedPriceSummary.toString();
    return Card(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_purchasedDate),
              Text("$_productSummary zł"),
            ],
          ),
        ),
        onTap: () => {
          _profileBloc.add(
            ShowBasketHistoryDialogEvent(
              basketHistoryId: basketHistory.id,
              purchasedDate: _purchasedDate,
              productSummary: _productSummary,
            ),
          )
        },
        splashFactory: InkSplash.splashFactory,
        splashColor: secondaryColor,
      ),
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
