//import 'package:bmt_sahabat_umat/view/pembiayaan/v_detail_angsuran.dart';
import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indonesia/indonesia.dart';
import 'package:bmt_sahabat_umat/model/Angsuran_model.dart';

class AngsuranMurabahah extends StatefulWidget {
  final String idMurabahah;
  AngsuranMurabahah({this.idMurabahah});
  @override
  _AngsuranMurabahahState createState() => _AngsuranMurabahahState();
}

class _AngsuranMurabahahState extends State<AngsuranMurabahah> {
  Future<List<AngsuranModel>> listAngsuran;
  AngsuranModel _angsuran = new AngsuranModel();

  @override
  void initState() {
    super.initState();
    listAngsuran = _angsuran.getAngsuran(widget.idMurabahah);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: widget.idMurabahah,
      ),
      body: FutureBuilder<List<AngsuranModel>>(
        future: listAngsuran,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? AngsuranList(
                  list: snapshot.data,
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class AngsuranList extends StatelessWidget {
  final List<AngsuranModel> list;
  AngsuranList({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
          child: Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      list[i].tglWajib == null
                          ? ''
                          : tanggal(DateTime.parse(list[i].tglWajib)),
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Jumlah Bayar',
                          style: TextStyle(
                              fontSize: 16.0, fontStyle: FontStyle.italic)),
                      Text(rupiah(list[i].totalBayar, trailing: ',00'),
                          style: TextStyle(fontSize: 16.0)),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Potongan',
                          style: TextStyle(
                              fontSize: 16.0, fontStyle: FontStyle.italic)),
                      Text(rupiah(list[i].totalBayar, trailing: ',00'),
                          style: TextStyle(fontSize: 16.0)),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      list[i].tglBayar == null
                          ? Text('')
                          : Text(tanggal(DateTime.parse(list[i].tglBayar))),
                      list[i].statusAngsuran == 0
                          ? BadgeAngsuran(
                              icon: FontAwesomeIcons.clock,
                              color: Colors.grey[400],
                              text: 'Belum Bayar',
                            )
                          : (list[i].statusAngsuran == 1
                              ? BadgeAngsuran(
                                  icon: FontAwesomeIcons.solidCheckCircle,
                                  color: Colors.green,
                                  text: 'Sudah Bayar',
                                )
                              : BadgeAngsuran(
                                  icon: FontAwesomeIcons.timesCircle,
                                  color: Colors.red,
                                  text: 'Tidak Bayar',
                                )),
                    ],
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

class BadgeAngsuran extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  BadgeAngsuran(
      {@required this.text, @required this.icon, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(text,
            style: TextStyle(
              color: color,
            )),
        Padding(
          padding: EdgeInsets.only(left: 5.0),
        ),
        Icon(
          icon,
          color: color,
          size: 20.0,
        )
      ],
    );
  }
}
