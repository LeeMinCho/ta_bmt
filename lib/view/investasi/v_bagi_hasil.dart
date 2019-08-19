import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bmt_sahabat_umat/helper/url_helper.dart';

class BagiHasil extends StatefulWidget {
  final String idInvestasi;
  BagiHasil({this.idInvestasi});
  @override
  _BagiHasilState createState() => _BagiHasilState();
}

class _BagiHasilState extends State<BagiHasil> {
  Future<List> getBagiHasil() async {
    final response = await http.post(baseUrl('investasi_mudharabah/bagi_hasil'), body: {
      'id_investasi': widget.idInvestasi
    });
    return json.decode(response.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: 'Bagi Hasil',
      ),
      body: Container(),
    );
  }
}