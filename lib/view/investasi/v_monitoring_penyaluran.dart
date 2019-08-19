import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmt_sahabat_umat/model/Angsuran_model.dart';

class Monitoring extends StatefulWidget {
  final String idMurabahah;
  Monitoring({this.idMurabahah});

  @override
  _MonitoringState createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
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
        title: 'Detail Angsuran',
      ),
      body: FutureBuilder<List<AngsuranModel>>(
        future: listAngsuran,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AngsuranList(list: snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber)),
            );
          }
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
      padding: EdgeInsets.symmetric(vertical: 10.0),
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
                      Text('Bayar Pokok',
                          style: TextStyle(
                              fontSize: 16.0, fontStyle: FontStyle.italic)),
                      Text(rupiah(list[i].bayarPokok, trailing: ',00'),
                          style: TextStyle(fontSize: 16.0)),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Bayar Margin',
                          style: TextStyle(
                              fontSize: 16.0, fontStyle: FontStyle.italic)),
                      Text(rupiah(list[i].bayarMargin, trailing: ',00'),
                          style: TextStyle(
                              fontSize: 16.0,
                              color: list[i].bayarMargin > 0
                                  ? Colors.green
                                  : Colors.black)),
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
