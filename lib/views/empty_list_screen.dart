import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class EmptyListScreen extends StatelessWidget {
  final String msg;
  final IconData? iconData;

  EmptyListScreen({
    required this.msg,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData ?? Icons.format_list_bulleted_rounded,
                size: 100,
                color: shadesThree,
              ),
              Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: shadesThree,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
