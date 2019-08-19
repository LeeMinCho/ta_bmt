import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmt_sahabat_umat/model/Penyaluran_model.dart';
import 'package:bmt_sahabat_umat/view/investasi/v_monitoring_penyaluran.dart';
import 'package:indonesia/indonesia.dart';

class PenggunaanDana extends StatefulWidget {
  final String idKlaster;
  final String namaKlaster;
  PenggunaanDana({this.idKlaster, this.namaKlaster});
  @override
  _PenggunaanDanaState createState() => _PenggunaanDanaState();
}

class _PenggunaanDanaState extends State<PenggunaanDana> {
  Future<List<PenyaluranModel>> listPenyaluran;
  PenyaluranModel _penyaluran = new PenyaluranModel();

  @override
  void initState() {
    super.initState();
    listPenyaluran = _penyaluran.getPenyaluran(widget.idKlaster);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: widget.namaKlaster,
      ),
      body: FutureBuilder<List<PenyaluranModel>>(
        future: listPenyaluran,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Penyaluran(list: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber)),
                );
        },
      ),
    );
  }
}

class Penyaluran extends StatelessWidget {
  final List<PenyaluranModel> list;
  Penyaluran({this.list});

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new Monitoring(
                                  idMurabahah: list[i].idMurabahah)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(list[i].idMurabahah,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600)),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Icon(
                              FontAwesomeIcons.play,
                              color: Colors.blue,
                              size: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /* Align(
                    alignment: Alignment.topRight,
                    child: Text(list[i].idMurabahah,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600)),
                  ), */
                  Divider(),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          list[i].namaLengkap,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Harga',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey)),
                            Text(
                                rupiah(list[i].besarMurabahah, trailing: ',00'),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300))
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Uang Muka',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey)),
                            Text(rupiah(list[i].uangMuka, trailing: ',00'),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300))
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Potensi Margin',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey)),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Icon(
                                    FontAwesomeIcons.chartLine,
                                    color: Colors.green,
                                    size: 15.0,
                                  ),
                                ),
                                Text(rupiah(list[i].margin, trailing: ',00'),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.green,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Penyaluran',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.grey)),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Icon(
                                    FontAwesomeIcons.exchangeAlt,
                                    color: Colors.red,
                                    size: 15.0,
                                  ),
                                ),
                                Text(rupiah(list[i].pokok, trailing: ',00'),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  /* ListTile(
                    trailing: Row(
                      children: <Widget>[
                        Text(rupiah(list[i].pokok, trailing: ',00'),
                            style: TextStyle(
                              color: Colors.red,
                            )),
                        Icon(
                          FontAwesomeIcons.exchangeAlt,
                          color: Colors.red,
                        )
                      ],
                    ),
                    title: Text(list[i].namaLengkap),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            'Harga: ${rupiah(list[i].besarMurabahah, trailing: ',00')}'),
                        Text(
                            'Uang Muka: ${rupiah(list[i].uangMuka, trailing: ',00')}'),
                        /* Text(
                            'Penyaluran: ${rupiah(list[i].pokok, trailing: ',00')}'), */
                      ],
                    ),
                  ), */
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
