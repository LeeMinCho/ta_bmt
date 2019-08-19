import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:bmt_sahabat_umat/model/Murabahah_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmt_sahabat_umat/view/pembiayaan/v_form_pengajuan.dart';
import 'package:bmt_sahabat_umat/view/pembiayaan/v_detail_pengajuan_murabahah.dart';

class ListPengajuan extends StatefulWidget {
  @override
  _ListPengajuanState createState() => _ListPengajuanState();
}

class _ListPengajuanState extends State<ListPengajuan> {
  Future<List<MurabahahModel>> listPengajuan;
  MurabahahModel _murabahah = new MurabahahModel();

  @override
  void initState() {
    super.initState();
    listPengajuan = _murabahah.getPengajuan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => new PengajuanMurabahah(),
          ));
          Scaffold.of(context).removeCurrentSnackBar();
          if (result != null) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('$result')));
            setState(() {
              listPengajuan = _murabahah.getPengajuan();
            });
          }
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<MurabahahModel>>(
        future: listPengajuan,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? PengajuanList(
                  list: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                );
        },
      ),
    );
  }
}

class PengajuanList extends StatelessWidget {
  final List<MurabahahModel> list;
  PengajuanList({this.list});

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                          child: Text(
                              tanggal(DateTime.parse(list[i].tglPengajuan)),
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new Pengajuan(
                                        detail: list[i],
                                      )));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Divider(),
                              ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.receipt,
                                  size: 38.0,
                                  color: Colors.grey[700],
                                ),
                                title: Text(
                                  list[i].idMurabahah,
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                subtitle: Text(
                                    'Harga : ${rupiah(list[i].estimasiHarga, trailing: ',00')}'),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        child: list[i].statusPengajuan == 0
                            ? new Badges(
                                icon: FontAwesomeIcons.clock,
                                color: Colors.grey,
                                text: 'Menunggu Persetujuan',
                              )
                            : new Badges(
                                icon: FontAwesomeIcons.solidTimesCircle,
                                color: Colors.red,
                                text: 'Ditolak',
                              ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class Badges extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const Badges(
      {Key key, @required this.icon, @required this.color, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Icon(
          icon,
          size: 15.0,
          color: color,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            text,
            style: TextStyle(color: color),
          ),
        )
      ],
    );
  }
}
