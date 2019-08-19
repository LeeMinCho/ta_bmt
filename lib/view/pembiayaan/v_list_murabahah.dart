import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/pembiayaan/v_detail_akad_murabahah.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indonesia/indonesia.dart';
import 'package:bmt_sahabat_umat/model/Murabahah_model.dart';

class ListMurabahah extends StatefulWidget {
  @override
  _ListMurabahahState createState() => _ListMurabahahState();
}

class _ListMurabahahState extends State<ListMurabahah> {
  Future<List<MurabahahModel>> listMurabahah;
  MurabahahModel _murabahah = new MurabahahModel();

  @override
  initState() {
    super.initState();
    listMurabahah = _murabahah.getMurabahah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<MurabahahModel>>(
        future: listMurabahah,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? MurabahahList(
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

class MurabahahList extends StatelessWidget {
  final List<MurabahahModel> list;
  MurabahahList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return list[i].message != ''
            ? Center(
                child: Text(list[i].message),
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
                                  builder: (context) => new AkadMurabahah(
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
                                  FontAwesomeIcons.shoppingBasket,
                                  size: 38.0,
                                  color: Colors.lightBlue,
                                ),
                                title: Text(
                                  list[i].idMurabahah,
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                subtitle: Text(
                                    'Harga : ${rupiah(list[i].besarMurabahah, trailing: ',00')}'),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        child: Badges(
                          icon: FontAwesomeIcons.solidCheckCircle,
                          color: Colors.green,
                          text: 'Disetujui',
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
