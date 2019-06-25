import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rann_github/common/variables.dart';
import 'package:rann_github/store/hub_state.dart';
import 'package:rann_github/style/style.dart';
import 'package:rann_github/util/local_storage.dart';
import 'package:rann_github/widget/flat_button.dart';
import 'package:rann_github/widget/input_widget.dart';
import 'package:rann_github/util/utils.dart';

class LoginPage extends StatefulWidget {
  static final String pName = 'login';
  LoginPage({Key key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState() : super();

  var _username;
  var _password;

  final TextEditingController userController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initParams();
  }

  _initParams() async {
    _username = await LocalStorage.get(Defines.USER_NAME_KEY);
    _password = await LocalStorage.get(Defines.PW_KEY);
    userController.value = TextEditingValue(text: _username ?? "");
    pwdController.value = TextEditingValue(text: _password ?? "");
  }

  _handleLogin() {
      print('login $_username $_password');
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<HubState>(builder: (context, store) {
      return Scaffold(
        backgroundColor: Color(HubColors.whiteThemeColor),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            child: Center(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                        image: AssetImage(HubIcons.DEFAULT_USER_ICON),
                        width: 90.0,
                        height: 90.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0)
                      ),
                      HubInputWidget(
                        hintText: Utils.getLocale(context).loginUserHint,
                        iconData: HubIcons.LOGIN_USER,
                        onChanged: (String value) {
                          _username = value;
                        },
                        controller: userController,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      HubInputWidget(
                        hintText: Utils.getLocale(context).loginPwdHint,
                        iconData: HubIcons.LOGIN_PW,
                        obscureText: true,
                        onChanged: (String value) {
                          _password = value;
                        },
                        controller: pwdController,
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                      ),
                      HubFlatButton(
                        padding: EdgeInsets.only(left: 20.0, top: 8.0, right: 20.0, bottom: 8.0),
                        text: Utils.getLocale(context).loginActionTitle,
                        textColor: Color(HubColors.textWhite),
                        color: Theme.of(context).primaryColor,
                        onPressed: _handleLogin
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
