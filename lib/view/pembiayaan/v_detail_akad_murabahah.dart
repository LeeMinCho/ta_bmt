import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/view/template/murabahah/v_template_murabahah.dart';
import 'package:bmt_sahabat_umat/view/pembiayaan/v_angsuran_murabahah.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmt_sahabat_umat/model/Murabahah_model.dart';
import 'package:indonesia/indonesia.dart';

class AkadMurabahah extends StatelessWidget {
  final MurabahahModel detail;
  AkadMurabahah({this.detail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: detail.idMurabahah,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'AKAD MURABAHAH',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.0),
                          Konten(
                              item: 'Item Murabahah',
                              detailItem: detail.itemMurabahah),
                          SizedBox(height: 8.0),
                          Konten(item: 'Jaminan', detailItem: detail.jaminan),
                          SizedBox(height: 8.0),
                          Nominal(
                            item: 'Harga Murabahah',
                            nominal: detail.besarMurabahah,
                          ),
                          SizedBox(height: 8.0),
                          Nominal(
                            item: 'Uang Muka',
                            nominal: detail.uangMuka,
                          ),
                          SizedBox(height: 8.0),
                          Konten(
                              item: 'Jangka Waktu',
                              detailItem: detail.jangkaWaktu),
                          SizedBox(height: 8.0),
                          Konten(
                              item: 'Tanggal Akad',
                              detailItem:
                                  tanggal(DateTime.parse(detail.tglAkad))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                child: Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Nominal(
                            nominal: detail.pokok,
                            item: 'Pokok',
                            colorNominal: Colors.green[600],
                            colorItem: Colors.green[600]),
                        SizedBox(
                          height: 8.0,
                        ),
                        Nominal(
                          nominal: detail.margin,
                          item: 'Margin',
                          colorNominal: Colors.green[600],
                          colorItem: Colors.green[600],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                child: Card(
                  elevation: 2.0,
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
                                    builder: (context) => new AngsuranMurabahah(
                                          idMurabahah: detail.idMurabahah,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('CICILAN PER BULAN',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600)),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Detail',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.green),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Icon(
                                        FontAwesomeIcons.caretRight,
                                        color: Colors.green,
                                        size: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Nominal(
                          nominal: detail.cicilanPokok,
                          item: 'Cicilan Pokok',
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Nominal(
                          nominal: detail.cicilanMargin,
                          item: 'Cicilan Margin',
                        ),
                        Divider(),
                        Nominal(
                          nominal: detail.totalCicilan,
                          item: 'Jumlah Cicilan',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
