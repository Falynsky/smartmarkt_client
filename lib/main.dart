import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/route_widget.dart';

Future<bool> addSelfSignedCertificate() async {
  ByteData data = await rootBundle.load('assets/keystore2.p12');
  SecurityContext context = SecurityContext.defaultContext;
  context.setTrustedCertificatesBytes(data.buffer.asUint8List(),
      password: 'password');
  return true;
}

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  await addSelfSignedCertificate();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
//      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: BlocProvider(
        create: (_) => RouteBloc(),
        child: RouteWidget(),
      ),
    );
  }
}
