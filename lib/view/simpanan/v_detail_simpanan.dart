import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/model/Simpanan_model.dart';
import 'package:intl/intl.dart';

class DetailSimpanan extends StatefulWidget {
  final List<SimpananModel> list;
  final int index;
  DetailSimpanan({this.index, this.list});
  @override
  _DetailSimpananState createState() => _DetailSimpananState();
}

class _DetailSimpananState extends State<DetailSimpanan> {
  final uang = new NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: 'Detail Simpanan',
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 250.0,
        padding: EdgeInsets.all(10.0),
        child: Card(
          child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[ListTile()],
              )),
        ),
      ),
    );
  }
}
