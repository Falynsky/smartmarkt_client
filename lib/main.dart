import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/views/route_widget.dart';

Future<bool> addSelfSignedCertificate() async {
  ByteData data = await rootBundle.load('assets/keystore2.p12');
  SecurityContext context = SecurityContext.defaultContext;
  context.setTrustedCertificatesBytes(data.buffer.asUint8List(),
      password: 'password');
  return true;
}

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartMarkt',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        accentColor: complementaryOne,
      ),
      home: RouteWidget(),
    );
  }
}
