import 'package:blood_bank/helper/colors.dart';
import 'package:blood_bank/models/person_donor.dart';
import 'package:blood_bank/provider/login_provider.dart';
import 'package:blood_bank/screen/donor_screen.dart';
import 'package:blood_bank/widgets.dart/generic_list_item.dart';
import 'package:blood_bank/widgets.dart/google_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as local;

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PersonDonor> items = [];
  bool _isLoaded = false;
  String bloodType = "notExist".tr();
  @override
  void initState() {
    super.initState();
    getdata();
  }

  static AnimationController? _controller;
  final SpinKitDualRing spinkit = SpinKitDualRing(
      color: Color(0xaaff0000), size: 50.0, controller: _controller);
  Future<void> getdata() async {
    await LoginProvider().getDonor().then((value) => items = value);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final user = Provider.of<LoginProvider>(context, listen: false);
    switch (user.user.donor!.bloodType) {
      case "1":
        bloodType = "A+";
        break;
      case "2":
        bloodType = "A-";
        break;
      case "3":
        bloodType = "B+";
        break;
      case "4":
        bloodType = "B-";
        break;
      case "5":
        bloodType = "AB+";
        break;
      case "6":
        bloodType = "AB-";
        break;
      case "7":
        bloodType = "O+";
        break;
      case "8":
        bloodType = "O-";
        break;
      default:
        bloodType = "notExist".tr();
    }
    if (!_isLoaded) {
      getdata().whenComplete(() {
        if (!mounted) return;
        _isLoaded = true;
        setState(() {});
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${"welcomeBack".tr()} ${user.user.name!.substring(0, (user.user.name!.indexOf(' ') == -1 ? user.user.name!.length : user.user.name!.indexOf(' ')))}'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(MyGoogleMap.routeName);
              },
              icon: Icon(
                Icons.near_me_sharp,
              ),
              color: Colors.white),
        ],
        leading: IconButton(
          onPressed: () {
            LoginProvider().logout(context);
          },
          icon: Icon(Icons.logout),
        ),
        backgroundColor: Colors.red[400],
      ),
      backgroundColor: color.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Container(
                height: 50,
                child:
                    GenericListItem("${user.user.name}", "${user.user.email}"),
              ),
            ),
            GenericListItem("basicData".tr(), " "),
            Container(
              height: height / 2.5,
              child: Card(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GenericListItem("firstName".tr(),
                          user.user.donor?.firstName ?? "notExist".tr()),
                      GenericListItem("lastName".tr(),
                          user.user.donor?.lastName ?? "notExist".tr()),
                      GenericListItem("identityNumber".tr(),
                          user.user.donor?.identityNumber ?? "notExist".tr()),
                      GenericListItem("address".tr(),
                          user.user.donor?.address ?? "notExist".tr()),
                      GenericListItem("bloodType".tr(), bloodType),
                      GenericListItem("dateOfBirth".tr(),
                          user.user.donor?.dateOfBirth ?? "notExist".tr()),
                      GenericListItem("phone".tr(),
                          "${user.user.donor?.phone ?? "notExist".tr()}"),
                    ],
                  ),
                ),
              ),
            ),
            GenericListItem("donationDate".tr(), "quantity".tr()),
            Card(
              child: Container(
                height: height / 2.58,
                child: (items.isEmpty)
                    ? !_isLoaded
                        ? Center(
                            child: spinkit,
                          )
                        : Center(
                            child: Text(
                              "noDonotion",
                              style: TextStyle(fontSize: 20),
                            ).tr(),
                          )
                    : ListView.builder(
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                    "${items[i].dateDonated!.substring(0, items[i].dateDonated!.indexOf(' '))}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  trailing: Text(
                                    "${items[i].quantity}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        Donoecreen.routeName,
                                        arguments: {
                                          'quantity': items[i].quantity,
                                          'createdAt': items[i].createdAt,
                                          'updatedAt': items[i].updatedAt,
                                          'dateDonated': items[i].dateDonated,
                                          'name': user.user.name!.substring(
                                              0,
                                              (user.user.name!.indexOf(' ') ==
                                                      -1
                                                  ? user.user.name!.length
                                                  : user.user.name!
                                                      .indexOf(' '))),
                                        });
                                  },
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        },
                        itemCount: items.length,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
