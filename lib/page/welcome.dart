import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rann_github/store/hub_state.dart';
import 'package:redux/redux.dart';

class WelcomePage extends StatefulWidget {
  static final String pName = '/';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Store<HubState> store = StoreProvider.of(context);
    Future.delayed(Duration(seconds: 2, milliseconds: 500), () {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Image(
            image: AssetImage('assets/image/welcome.png'),
          )
      )
    );
  }
}