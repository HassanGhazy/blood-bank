import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ListTileWidget extends StatelessWidget {
  ListTileWidget(
      {required this.id, required this.value, required IconData this.icon});
  final String? id;
  final String? value;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Card(
        child: ListTile(
          title: Text(
            id!,
            style: TextStyle(fontSize: 14),
          ),
          trailing: (id! == "${"dateCreatedAt".tr()}")
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value!.substring(0, value!.indexOf('T')),
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      value!.substring(
                          value!.indexOf('T') + 1, value!.indexOf('.')),
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                )
              : Text(
                  value!,
                  style: TextStyle(fontSize: 14),
                ),
          leading: Icon(icon!),
        ),
      ),
    );
  }
}
