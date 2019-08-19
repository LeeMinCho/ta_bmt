import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indonesia/indonesia.dart';
import 'package:bmt_sahabat_umat/model/Detail_klaster_model.dart';

class DetailKlaster extends StatefulWidget {
  final String idKlaster;
  final String namaKlaster;
  DetailKlaster({this.idKlaster, this.namaKlaster});
  @override
  _DetailKlasterState createState() => _DetailKlasterState();
}

class _DetailKlasterState extends State<DetailKlaster> {
  Future<List<DetailKlasterModel>> listInvestor;
  DetailKlasterModel _detailKlaster = new DetailKlasterModel();

  @override
  void initState() {
    super.initState();
    listInvestor = _detailKlaster.getDetailKlaster(widget.idKlaster);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: 'Klaster ' + widget.namaKlaster,
      ),
      body: FutureBuilder<List<DetailKlasterModel>>(
        future: listInvestor,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? InvestorList(list: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber)),
                );
        },
      ),
    );
  }
}

class InvestorList extends StatelessWidget {
  final List<DetailKlasterModel> list;
  InvestorList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        list[i].idInvestasi,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16.0),
                      )),
                  Divider(),
                  ListTile(
                    title: Text(list[i].nama),
                    subtitle: Text('Porsi : ${list[i].porsiBasil}'),
                    trailing: Text(
                      rupiah(list[i].besarInvestasi, trailing: ',00'),
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
