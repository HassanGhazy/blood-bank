import 'package:flutter/material.dart';

class GenericListItem extends StatelessWidget {
  final String? id;
  final String? value;

  const GenericListItem(this.id, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(id!),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: -1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value!),
          ),
        ),
      ],
    );
  }
}
