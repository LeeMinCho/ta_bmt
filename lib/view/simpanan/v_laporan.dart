import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:path_provider/path_provider.dart';
import 'package:bmt_sahabat_umat/model/Simpanan_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class CetakPDF extends StatefulWidget {
  @override
  _CetakPDFState createState() => _CetakPDFState();
}

class _CetakPDFState extends State<CetakPDF> {
  String _tahun = '';
  int _year = DateTime.now().year;
  String _errorTahun = '';
  bool _prosesCetak = false;

  void _showDatePicker() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        initialYear: _year,
        confirm: Text('Pilih'),
        cancel: Text('Batal'),
        locale: 'en',
        dateFormat: 'yyyy', onConfirm: (year, _, __) {
      setState(() {
        _tahun = year.toString();
      });
    });
  }

  /* void _cetakPDF(context, List<SimpananModel> data) async {
    final pdfLib.Document pdf = pdfLib.Document();
    int i = 1;
    pdf.addPage(pdfLib.MultiPage(
        pageFormat: PdfPageFormat.a4
            .applyMargin(left: 2.0, right: 2.0, bottom: 2.0, top: 2.0),
        build: (context) => [
              pdfLib.Table.fromTextArray(context: context, data: <List<String>>[
                <String>['No.', 'Tanggal Transaksi', 'Besar Simpanan'],
                data
                    .map((item) => [i++, item.tglTransaksi, item.besarSimpanan])
                    .cast()
              ]),
              pdfLib.ListView(children: [])
            ]));
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/laporan_' + _tahun.toString();
    final File file = File(path);
    await file.writeAsBytes(pdf.save());

    setState(() {
      _prosesCetak = false;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: Icon(FontAwesomeIcons.calendar),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: _tahun == ''
                        ? Text('tahun', style: TextStyle(color: Colors.grey))
                        : Text(_tahun.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Divider(color: Colors.black87),
                  ),
                  Text(_errorTahun,
                      style: TextStyle(fontSize: 12.5, color: Colors.red))
                ],
              ),
              trailing: SizedBox(
                width: 30.0,
                child: FlatButton(
                  onPressed: _showDatePicker,
                  child: Icon(FontAwesomeIcons.caretDown, size: 20.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              onPressed: () {
                if (_tahun == '') {
                  setState(() {
                    _errorTahun = 'Silahkan pilih tahun!';
                  });
                } else {
                  setState(() {
                    _prosesCetak = true;
                  });
                  /* SimpananModel.getLaporan(_tahun.toString()).then((value) {
                    if (value.isNotEmpty) {
                      _cetakPDF(context, value);
                    }
                  }); */
                }
              },
              color: Colors.amber,
              child: _prosesCetak == false
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Cetak Laporan',
                            style: TextStyle(color: Colors.white)),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(FontAwesomeIcons.solidFilePdf,
                              color: Colors.white),
                        )
                      ],
                    )
                  : CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
