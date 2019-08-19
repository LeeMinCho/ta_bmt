import 'package:flutter/material.dart';
//import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/view/investasi/v_detail_investasi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmt_sahabat_umat/model/Mudharabah_model.dart';
import 'package:indonesia/indonesia.dart';

class ListInvestasi extends StatefulWidget {
  @override
  _ListInvestasiState createState() => _ListInvestasiState();
}

class _ListInvestasiState extends State<ListInvestasi> {
  Future<List<MudharabahModel>> listInvestasi;
  MudharabahModel _mudharabah = new MudharabahModel();

  @override
  void initState() {
    super.initState();
    listInvestasi = _mudharabah.getInvestasi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<MudharabahModel>>(
        future: listInvestasi,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? InvestasiList(
                  list: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber)),
                );
        },
      ),
    );
  }
}

class InvestasiList extends StatelessWidget {
  final List<MudharabahModel> list;
  InvestasiList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return list[i].message == ''
            ? Container(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 0.0),
                child: Card(
                  elevation: 2.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            tanggal(DateTime.parse(list[i].tglSetor)),
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new DetailInvestasi(
                                        detail: list[i],
                                      )));
                        },
                        leading: Icon(
                          FontAwesomeIcons.fileInvoiceDollar,
                          color: Colors.blue,
                          size: 35.0,
                        ),
                        title: Text(list[i].idInvestasi),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                rupiah(list[i].besarInvestasi, trailing: ',00'),
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Text(list[i].message),
              );
      },
    );
  }
}
