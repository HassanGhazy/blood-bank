import 'package:blood_bank/helper/storge.dart';
import 'package:blood_bank/provider/login_provider.dart';
import 'package:blood_bank/screen/donor_screen.dart';
import 'package:blood_bank/screen/home.dart';
import 'package:blood_bank/screen/login.dart';
import 'package:blood_bank/widgets.dart/google_map.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("69bbe209-a6ab-453e-b23f-3ffb908cc942");

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('ar'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LoginProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blood Bank',
        theme: ThemeData(
          primaryColor: Colors.red[400],
        ),
        home: (shared.getData("login") == true) ? Home() : Login(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: {
          Home.routeName: (ctx) => Home(),
          MyGoogleMap.routeName: (ctx) => MyGoogleMap(),
          Donoecreen.routeName: (ctx) => Donoecreen(),
        },
      ),
    );
  }
}
