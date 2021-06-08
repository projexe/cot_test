import 'package:capitalontap_coding_test/account/create/bloc/create_account_bloc.dart';
import 'package:capitalontap_coding_test/account/create/ui/create-account.dart';
import 'package:capitalontap_coding_test/config/di_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initialiseServiceProviders();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cap on Tap Account',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => CreateAccountBloc(),
        child: CreateAccountPage(),
      ),
    );
  }
}
