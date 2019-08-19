import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:intl/intl.dart';
import 'package:bmt_sahabat_umat/model/Angsuran_model.dart';

class DetailAngsuran extends StatefulWidget {
  final AngsuranModel detail;
  DetailAngsuran({this.detail});
  @override
  _DetailAngsuranState createState() => _DetailAngsuranState();
}

class _DetailAngsuranState extends State<DetailAngsuran> {
  final uang = new NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: 'Detail Angsuran',
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              children: [
                TableRow(children: [
                  Text('Angsuran ke'),
                  Text(': ' + widget.detail.angsuranKe)
                ]),
                TableRow(children: [
                  Text('Jatuh Tempo'),
                  Text(': ' + widget.detail.tglWajib)
                ]),
                TableRow(children: [
                  Text('Tanggal Bayar'),
                  Text(widget.detail.tglBayar == null
                      ? ':'
                      : ': ' + widget.detail.tglBayar)
                ]),
                TableRow(children: [
                  Text('Jumlah Bayar'),
                  Text(': ' +
                      uang
                          .format(widget.detail.totalBayar)
                          .replaceAll(',', '.'))
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
