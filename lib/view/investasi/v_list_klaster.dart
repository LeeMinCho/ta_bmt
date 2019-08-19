import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/investasi/v_penggunaan_dana.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indonesia/indonesia.dart';
import 'package:bmt_sahabat_umat/model/Klaster_model.dart';
import 'package:bmt_sahabat_umat/view/investasi/v_detail_klaster.dart';

class ListKlaster extends StatefulWidget {
  @override
  _ListKlasterState createState() => _ListKlasterState();
}

class _ListKlasterState extends State<ListKlaster> {
  Future<List<KlasterModel>> listKlaster;
  KlasterModel _klaster = new KlasterModel();

  @override
  void initState() {
    super.initState();
    listKlaster = _klaster.getKlaster();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listKlaster,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return KlasterList(list: snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber)),
          );
        }
      },
    );
  }
}

enum KlasterPage { detailPage, penyaluranPage }

class KlasterList extends StatelessWidget {
  final List<KlasterModel> list;
  KlasterList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return list[i].message != ''
            ? Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.8,
                    ),
                    Text(list[i].message, style: TextStyle(fontSize: 20.0))
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                child: Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            list[i].klaster,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Divider(),
                        ListTile(
                            subtitle: Text(
                                'Saldo: ${rupiah(list[i].saldo, trailing: ',00')}'),
                            trailing: ActionMenu(
                              idKlaster: list[i].idKlaster,
                              namaKlaster: list[i].klaster,
                            ),
                            leading: Icon(FontAwesomeIcons.users,
                                size: 35.0, color: Colors.blue),
                            title: Text(
                                rupiah(list[i].nominalInvestasi,
                                    trailing: ',00'),
                                style: TextStyle(
                                  color: Colors.green,
                                ))),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class ActionMenu extends StatelessWidget {
  final String idKlaster;
  final String namaKlaster;
  ActionMenu({this.idKlaster, this.namaKlaster});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<KlasterPage>(
      onSelected: (KlasterPage value) {
        switch (value) {
          case KlasterPage.detailPage:
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new DetailKlaster(
                      idKlaster: idKlaster, namaKlaster: namaKlaster),
                ));
            break;
          case KlasterPage.penyaluranPage:
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new PenggunaanDana(
                      idKlaster: idKlaster, namaKlaster: namaKlaster),
                ));
            break;
          default:
        }
      },
      padding: EdgeInsets.all(10.0),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<KlasterPage>>[
            PopupMenuItem<KlasterPage>(
              value: KlasterPage.detailPage,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.eye, color: Colors.grey),
                title: Text('Detail Klaster'),
              ),
            ),
            PopupMenuItem<KlasterPage>(
              value: KlasterPage.penyaluranPage,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.share, color: Colors.grey),
                title: Text('Penyaluran'),
              ),
            ),
          ],
    );
  }
}
