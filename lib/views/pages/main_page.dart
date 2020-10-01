import 'package:flutter/material.dart';
import 'package:smartmarktclient/card/dashboard_card.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Smart Markt"),
        ),
        elevation: .1,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Color(0xFF40c5ba),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 2),
        child: GridView.builder(
            itemCount: gridViewData.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return DashboardCard(
                label: gridViewData[index]['label'],
                iconData: gridViewData[index]['iconData'],
                pageIdn: gridViewData[index]['pageIdn'],
              );
            }),
      ),
    );
  }

  List<Map<String, dynamic>> gridViewData = [
    {'label': 'Produkty', 'iconData': Icons.fastfood, 'pageIdn': 'products'},
    {'label': 'Skaner', 'iconData': Icons.scanner, 'pageIdn': 'scanner'},
    {'label': 'Promocje', 'iconData': Icons.alarm, 'pageIdn': 'sales'},
    {'label': 'Koszyk', 'iconData': Icons.shopping_basket, 'pageIdn': 'basket'},
    {'label': 'Profil', 'iconData': Icons.person, 'pageIdn': 'profile'},
    {'label': 'Ustawienia', 'iconData': Icons.settings, 'pageIdn': 'settings'},
  ];
}
