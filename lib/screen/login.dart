import 'package:blood_bank/provider/login_provider.dart';
import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  static AnimationController? _controller;
  bool _validatePassword = false;
  bool _hidePass = true;

  final _passFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // _emailController.text = "ahmad@gm.co";
    // _passController.text = "123456789";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _sendAuth() {
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        return;
      }
      _form.currentState!.save();
      login();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('login').tr(),
        centerTitle: true,
        backgroundColor: Colors.red[400],
        actions: [
          IconButton(
              onPressed: () {
                Locale locale = local.EasyLocalization.of(context)!.locale;
                local.EasyLocalization.of(context)!.setLocale(
                    locale == Locale("ar") ? Locale("en") : Locale("ar"));
              },
              icon: Icon(Icons.language_sharp),
              tooltip: 'change'.tr())
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'welcome',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ).tr(),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'email',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            SizedBox(
              height: 7,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passFocusNode);
              },
              validator: (value) {
                if (value!.isEmpty) return 'validEmail'.tr();
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                prefixIcon: Icon(Icons.mail),
                hintText: 'hintEmail'.tr(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'password',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ).tr(),
            SizedBox(
              height: 7,
            ),
            TextFormField(
              obscureText: _hidePass,
              controller: _passController,
              validator: (value) {
                if (value!.isEmpty) return 'validEmail'.tr();
                return null;
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                errorText: _validatePassword ? 'validPassword'.tr() : null,
                hintText: 'hintPassword'.tr(),
                prefixIcon: IconButton(
                  icon: _hidePass
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Consumer<LoginProvider>(
                builder: (context, loginProvider, child) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red[400]!),
                    ),
                    onPressed: () {
                      _sendAuth();
                    },
                    child: loginProvider.logInLoading
                        ? spinkit
                        : Text(
                            'login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ).tr(),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  final SpinKitDoubleBounce spinkit = SpinKitDoubleBounce(
      color: Colors.white, size: 50.0, controller: _controller);
  Future<void> login() async {
    Provider.of<LoginProvider>(context, listen: false)
        .login(_emailController.text, _passController.text, context);
  }
}
