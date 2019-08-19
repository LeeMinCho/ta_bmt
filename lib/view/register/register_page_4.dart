import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/helper/form_helper.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/view/v_login.dart';
import 'package:bmt_sahabat_umat/library/form_validation.dart';
import 'package:bmt_sahabat_umat/model/Register_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage4 extends StatefulWidget {
  static String tag = 'registerPage4';
  final data;
  RegisterPage4({this.data});
  @override
  _RegisterPage4State createState() => _RegisterPage4State();
}

class _RegisterPage4State extends State<RegisterPage4> with Validation {
  final formKey = GlobalKey<FormState>();
  final TextEditingController wajib = new TextEditingController();
  bool _prosesPendaftaran = false;

  void _showSuccess() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return _prosesPendaftaran == false
              ? AlertDialog(
                  title: Text('Simpan Pendaftaran Anggota'),
                  content: _prosesPendaftaran == false
                      ? Text(
                          'Data Pendaftaran akan disimpan dan proses selanjutnya akan diproses pengurus. Pastikan data sudah benar! Lanjutkan?',
                          textAlign: TextAlign.left,
                        )
                      : CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.amber),
                        ),
                  actions: <Widget>[
                    RaisedButton(
                      color: Colors.grey,
                      child:
                          Text('Batal', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text('OK', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        setState(() {
                          _prosesPendaftaran = true;
                        });
                        widget.data['wajib'] = wajib.text;
                        RegisterModel.insertPendaftaran(widget.data)
                            .then((value) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginPage(pesan: value.message)));
                        });
                      },
                    ),
                  ],
                )
              : AlertDialog(
                  content: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                  ),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRegister(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Mengajukan permohonan menjadi anggota KSPPS  BMT Sahabat Umat dengan memenuhi kewajiban membayar simpanan pokok dan simpanan wajib',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                ListTile(
                  leading: Icon(
                    Icons.check_box,
                  ),
                  title: Text('Simpanan pokok Rp100.000,00'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.check_box,
                  ),
                  title: Text('Simpanan wajib (Rp10.000-Rp50.000)'),
                ),
                FormInput(
                  validator: validateRequired,
                  controller: wajib,
                  hint: '10000',
                  label: 'Simpanan wajib',
                  keyboard: TextInputType.number,
                  icon: FontAwesomeIcons.solidSave,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                ),
                RaisedButton(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: new Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      _showSuccess();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
