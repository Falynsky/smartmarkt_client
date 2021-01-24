import 'package:flutter/material.dart';
import 'package:smartmarktclient/http/http_service.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class LargeImageDialog {
  void showDialogBox(BuildContext context, String documentUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: shadesThree,
          content: Row(
            children: [
              Flexible(
                child: Image.network(
                  documentUrl,
                  headers: HttpService.headers,
                  errorBuilder: (_, __, ___) {
                    return Icon(Icons.image_not_supported, size: 300);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
