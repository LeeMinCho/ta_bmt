import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:bmt_sahabat_umat/model/Simpanan_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListSimpanan extends StatefulWidget {
  @override
  _ListSimpananState createState() => _ListSimpananState();
}

class _ListSimpananState extends State<ListSimpanan> {
  Future<List<SimpananModel>> listSimpanan;
  SimpananModel _simpanan = new SimpananModel();

  @override
  void initState() {
    super.initState();
    listSimpanan = _simpanan.getSimpanan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SimpananModel>>(
        future: listSimpanan,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SimpananList(
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

class SimpananList extends StatelessWidget {
  final List<SimpananModel> list;
  SimpananList({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return list[i].message == ''
            ? Container(
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                child: Card(
                  elevation: 2.0,
                  child: ListTile(
                      /* onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new DetailSimpanan(
                                      list: list,
                                      index: i,
                                    )));
                      }, */
                      leading: Icon(
                        FontAwesomeIcons.coins,
                        color: Colors.amber,
                      ),
                      trailing: Text(
                        rupiah(list[i].besarSimpanan, trailing: ',00'),
                        style: TextStyle(color: Colors.green),
                      ),
                      title:
                          Text(tanggal(DateTime.parse(list[i].tglTransaksi))),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text('Simpanan ${list[i].jenisSimpanan}'),
                      )),
                ),
              )
            : Center(
                child: Text(list[i].message),
              );
      },
    );
  }
}
