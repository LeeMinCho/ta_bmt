import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/helper/form_helper.dart';
import 'package:bmt_sahabat_umat/view/register/register_page_4.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/library/form_validation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage3 extends StatefulWidget {
  static String tag = 'registerPage3';
  final data;
  RegisterPage3({this.data});
  @override
  _RegisterPage3State createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> with Validation {
  final formKey = GlobalKey<FormState>();
  String statusRumah = '';
  final TextEditingController pekerjaan = new TextEditingController();
  final TextEditingController pendidikan = new TextEditingController();
  final TextEditingController kantor = new TextEditingController();
  final TextEditingController gaji = new TextEditingController();
  final TextEditingController jabatan = new TextEditingController();
  String errorStatusRumah = '';
  void _pilihStatus(String value) {
    setState(() {
      statusRumah = value;
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
                ListTile(
                  leading: Icon(FontAwesomeIcons.home),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 'Milik Sendiri',
                            activeColor: Colors.amber,
                            groupValue: statusRumah,
                            onChanged: (String value) {
                              _pilihStatus(value);
                            },
                          ),
                          Text('Milik Sendiri')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 'Kontrak',
                            activeColor: Colors.amber,
                            groupValue: statusRumah,
                            onChanged: (String value) {
                              _pilihStatus(value);
                            },
                          ),
                          Text('Kontrak')
                        ],
                      ),
                      Text(
                        '$errorStatusRumah',
                        style: TextStyle(fontSize: 12.5, color: Colors.red),
                      ),
                    ],
                  ),
                ),
                FormInput(
                  validator: validateRequired,
                  controller: pekerjaan,
                  hint: 'Pekerjaan',
                  label: 'Pekerjaan',
                  icon: FontAwesomeIcons.briefcase,
                ),
                FormInput(
                  validator: validateRequired,
                  controller: pendidikan,
                  hint: 'Pendidikan',
                  label: 'Pendidikan',
                  icon: FontAwesomeIcons.graduationCap,
                ),
                TextArea(
                  validator: validateRequired,
                  controller: kantor,
                  hint: 'Nama dan Alamat Kantor',
                  label: 'Nama dan Alamat Kantor',
                  icon: FontAwesomeIcons.building,
                ),
                FormInput(
                  controller: jabatan,
                  hint: 'Jabatan',
                  label: 'Jabatan',
                  icon: FontAwesomeIcons.userTie,
                ),
                FormInput(
                  validator: validateRequired,
                  controller: gaji,
                  hint: 'Penghasilan',
                  label: 'Penghasilan',
                  keyboard: TextInputType.number,
                  icon: FontAwesomeIcons.moneyCheckAlt,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  textColor: Colors.white,
                  color: Colors.amber,
                  child: Text('Selanjutnya'),
                  onPressed: () {
                    if (formKey.currentState.validate() && statusRumah != '') {
                      widget.data['statusRumah'] = statusRumah;
                      widget.data['pekerjaan'] = pekerjaan.text;
                      widget.data['pendidikan'] = pendidikan.text;
                      widget.data['kantor'] = kantor.text;
                      widget.data['gaji'] = gaji.text;
                      widget.data['jabatan'] = jabatan.text;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterPage4(
                              data: widget.data,
                            ),
                      ));
                    } else {
                      setState(() {
                        if (statusRumah == '') {
                          errorStatusRumah = 'Harus Dipilih!';
                        } else {
                          errorStatusRumah = '';
                        }
                      });
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
