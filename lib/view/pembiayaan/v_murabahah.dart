import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/pembiayaan/v_list_murabahah.dart';
import 'package:bmt_sahabat_umat/view/pembiayaan/v_list_pengajuan.dart';

class Murabahah extends StatefulWidget {
  @override
  _MurabahahState createState() => _MurabahahState();
}

class _MurabahahState extends State<Murabahah> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Murabahah'),
          bottom: TabBar(
            indicatorColor: Colors.amber,
            tabs: <Widget>[
              Tab(text: 'Pengajuan'),
              Tab(text: 'Akad Murabahah'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListPengajuan(),
            ListMurabahah(),
          ],
        ),
      ),
    );
  }
}
