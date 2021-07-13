import 'package:blood_bank/helper/colors.dart';
import 'package:blood_bank/widgets.dart/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Donoecreen extends StatelessWidget {
  static const String routeName = '/donor-screen';
  @override
  Widget build(BuildContext context) {
    final Map<String?, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String?, dynamic>;
    final String? dateDonate = data['dateDonated'];
    final int? quantity = data['quantity'];
    final String? updatedAt = data['updatedAt'];
    final String? createdAt = data['createdAt'];
    final String? name = data['name'];
    print(updatedAt);
    print(updatedAt);
    print(updatedAt);
    return Scaffold(
      backgroundColor: color.grey,
      appBar: AppBar(
        title: Text(name!),
        backgroundColor: Colors.red[400],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTileWidget(
                id: "dateCreatedAt".tr(),
                value: "$createdAt",
                icon: Icons.date_range),
            ListTileWidget(
                id: "dateUpdatedAt".tr(),
                value:
                    "${updatedAt!.substring(updatedAt.indexOf('T') + 1, updatedAt.indexOf('.'))}",
                icon: Icons.timer),
            ListTileWidget(
                id: "quantity".tr(),
                value: "$quantity",
                icon: Icons.add_box_outlined),
            ListTileWidget(
                id: "donationDate".tr(),
                value: "$dateDonate".substring(0, dateDonate!.indexOf(' ')),
                icon: Icons.date_range),
          ],
        ),
      ),
    );
  }
}
