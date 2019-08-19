import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/library/form_validation.dart';
import 'package:bmt_sahabat_umat/helper/form_helper.dart';
import 'package:bmt_sahabat_umat/model/Murabahah_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PengajuanMurabahah extends StatefulWidget {
  @override
  _PengajuanMurabahahState createState() => _PengajuanMurabahahState();
}

class _PengajuanMurabahahState extends State<PengajuanMurabahah>
    with Validation {
  final formKey = GlobalKey<FormState>();
  TextEditingController harga = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController jangkaWaktu = TextEditingController();
  TextEditingController kesanggupanCicil = TextEditingController();
  TextEditingController jaminan = TextEditingController();
  TextEditingController uangMuka = TextEditingController();
  bool _prosesPengajuan = false;
  Map<String, String> data = Map();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: 'Form Pengajuan',
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              FormInput(
                controller: harga,
                validator: validateRequired,
                label: 'Estimasi Harga',
                hint: '500000',
                keyboard: TextInputType.number,
                icon: FontAwesomeIcons.moneyBill,
              ),
              FormInput(
                controller: item,
                label: 'Item Murabahah',
                hint: 'Item Murabahah',
                validator: validateRequired,
                icon: FontAwesomeIcons.shoppingCart,
              ),
              FormInput(
                controller: jangkaWaktu,
                validator: validateRequired,
                label: 'Jangka Waktu',
                hint: 'Dalam Bulan',
                keyboard: TextInputType.number,
                icon: FontAwesomeIcons.clock,
              ),
              FormInput(
                  controller: kesanggupanCicil,
                  validator: validateRequired,
                  label: 'Kesanggupan Cicilan',
                  hint: '500000',
                  keyboard: TextInputType.number,
                  icon: FontAwesomeIcons.moneyCheckAlt),
              FormInput(
                controller: jaminan,
                validator: validateRequired,
                label: 'Jaminan',
                hint: 'Jaminan',
                icon: FontAwesomeIcons.fileInvoice,
              ),
              FormInput(
                controller: uangMuka,
                validator: validateRequired,
                label: 'Uang Muka',
                hint: '500000',
                keyboard: TextInputType.number,
                icon: FontAwesomeIcons.handHoldingUsd,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              RaisedButton(
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: _prosesPengajuan == false
                    ? Text(
                        'Ajukan',
                        style: TextStyle(color: Colors.white),
                      )
                    : CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    data['estimasi_harga'] = harga.text;
                    data['item_murabahah'] = item.text;
                    data['jangka_waktu'] = jangkaWaktu.text;
                    data['kesanggupan_cicilan'] = kesanggupanCicil.text;
                    data['jaminan'] = jaminan.text;
                    data['uang_muka'] = uangMuka.text;
                    setState(() {
                      _prosesPengajuan = true;
                    });
                    MurabahahModel.insertPengajuan(data).then((value) {
                      setState(() {
                        _prosesPengajuan = false;
                      });
                      Navigator.of(context).pop(value.message);
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
