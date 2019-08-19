import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/view/simpanan/v_laporan.dart';
import 'package:bmt_sahabat_umat/view/simpanan/v_list_simpanan.dart';

class Simpanan extends StatefulWidget {
  static String tag = 'Simpanan';

  @override
  _SimpananState createState() => _SimpananState();
}

class _SimpananState extends State<Simpanan> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Simpanan'),
          bottom: TabBar(
            indicatorColor: Colors.amber,
            tabs: <Widget>[
              Tab(text: 'Riwayat Simpanan'),
              Tab(text: 'Cetak Laporan'),
            ],
          ),
        ),
        drawer: new Template(
          simpanan: true,
        ),
        body: TabBarView(
          children: <Widget>[ListSimpanan(), CetakPDF()],
        ),
      ),
    );
  }
}
