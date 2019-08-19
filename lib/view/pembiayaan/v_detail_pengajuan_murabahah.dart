import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/view/template/murabahah/v_template_murabahah.dart';
import 'package:bmt_sahabat_umat/model/Murabahah_model.dart';

class Pengajuan extends StatelessWidget {
  final MurabahahModel detail;
  Pengajuan({this.detail});

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
                child: Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'PENGAJUAN MURABAHAH',
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
                          item: 'Estimasi Harga',
                          nominal: detail.estimasiHarga,
                        ),
                        SizedBox(height: 8.0),
                        Nominal(
                          item: 'Uang Muka',
                          nominal: detail.uangMuka,
                        ),
                        SizedBox(height: 8.0),
                        Nominal(
                          item: 'Kesanggupan Cicilan',
                          nominal: detail.kesanggupanCicilan,
                        ),
                        SizedBox(height: 8.0),
                        Konten(
                            item: 'Jangka Waktu',
                            detailItem: detail.jangkaWaktu + ' bulan'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
