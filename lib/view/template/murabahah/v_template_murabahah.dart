import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';

class Konten extends StatelessWidget {
  const Konten({
    Key key,
    @required this.item,
    @required this.detailItem,
  }) : super(key: key);

  final String item;
  final String detailItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          item,
          style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
        ),
        Text(
          detailItem,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}

class Nominal extends StatelessWidget {
  const Nominal(
      {Key key,
      @required this.nominal,
      @required this.item,
      this.colorNominal = Colors.black,
      this.colorItem})
      : super(key: key);

  final int nominal;
  final String item;
  final Color colorItem;
  final Color colorNominal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(item,
            style: TextStyle(
                fontSize: 16.0,
                color: colorItem == null ? Colors.grey[700] : colorItem)),
        Text(rupiah(nominal, trailing: ',00'),
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
                color: colorNominal))
      ],
    );
  }
}
