import 'package:capitalontap_coding_test/config/config.dart';
import 'package:flutter/material.dart';

class AccountDataRow extends StatelessWidget {
  final String label;
  final Widget value;

  AccountDataRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text('$label:',
                      style: TextStyle(
                        fontSize: Config.fontsize_details_label,
                      ),
                      overflow: TextOverflow.clip),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                      width: 20,
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.all(10),
                      child: value),
                ),
              ],
            ),
          ),
          Divider(
            height: 5,
          )
        ],
      ),
    );
  }
}

class AccountValueText extends StatelessWidget {
  final String text;
  const AccountValueText(this.text);

  @override
  Widget build(BuildContext context) => Text(
        '$text',
        style: TextStyle(
            fontSize: Config.fontsize_details_value,
            fontWeight: FontWeight.bold),
        overflow: TextOverflow.clip,
      );
}
