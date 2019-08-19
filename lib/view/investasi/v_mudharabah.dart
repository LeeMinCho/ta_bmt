import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/view/investasi/v_list_investasi.dart';
import 'package:bmt_sahabat_umat/view/investasi/v_list_klaster.dart';

class Mudharabah extends StatelessWidget {
  static final String tag = 'Mudharabah';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Mudharabah'),
          bottom: TabBar(
            indicatorColor: Colors.amber,
            tabs: <Widget>[
              Tab(
                text: 'Riwayat Investasi',
              ),
              Tab(
                text: 'Klaster',
              )
            ],
          ),
        ),
        drawer: Template(
          investasi: true,
        ),
        body: TabBarView(
          children: <Widget>[ListInvestasi(), ListKlaster()],
        ),
      ),
    );
  }
}
