import 'package:bmt_sahabat_umat/model/Anggota_model.dart';
import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/helper/form_helper.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/view/register/register_page_2.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:bmt_sahabat_umat/library/form_validation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage1 extends StatefulWidget {
  static String tag = 'registerPage1';
  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> with Validation {
  final formKey = GlobalKey<FormState>();
  final TextEditingController id = new TextEditingController();
  final TextEditingController namaLengkap = new TextEditingController();
  final TextEditingController alamat = new TextEditingController();
  final TextEditingController tempatLahir = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController noTelp = new TextEditingController();
  String tglLahir = '';
  String stglLahir = '';
  String jenisID = '';
  String jk = '';
  String errorJenisID = '';
  String errorTglLahir = '';
  String errorJK = '';
  String errorID = '';
  bool _cekID = false;
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _date = DateTime.now().day;
  List<String> agama = [
    'Islam',
    'Kristen Katholik',
    'Kristen Protestan',
    'Hindhu',
    'Buddha'
  ];
  String _agama = 'Islam';
  Map<String, String> data = Map();
  void _pilihID(String value) {
    setState(() {
      jenisID = value;
    });
  }

  void _pilihJK(String value) {
    setState(() {
      jk = value;
    });
  }

  void _showDatePicker() {
    final bool showTitleActions = false;
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      initialYear: _year,
      initialMonth: _month,
      initialDate: _date,
      confirm: new Text('Pilih'),
      cancel: new Text('Batal'),
      locale: 'en',
      dateFormat: 'dd-mm-yyyy',
      onChanged: (year, month, date) {
        if (!showTitleActions) {
          _changeDatetime(year, month, date);
        }
      },
      onConfirm: (year, month, date) {
        _changeDatetime(year, month, date);
      },
    );
  }

  void _changeDatetime(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      stglLahir = '$date-$month-$year';
      tglLahir = '$year-$month-$date';
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
                  leading: Icon(FontAwesomeIcons.idCardAlt),
                  subtitle: Text(
                    '$errorJenisID',
                    style: TextStyle(fontSize: 12.5, color: Colors.red),
                  ),
                  title: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 'SIM',
                            groupValue: jenisID,
                            activeColor: Colors.amber,
                            onChanged: (String value) {
                              _pilihID(value);
                            },
                          ),
                          Text('SIM')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 'KTP',
                            groupValue: jenisID,
                            activeColor: Colors.amber,
                            onChanged: (String value) {
                              _pilihID(value);
                            },
                          ),
                          Text('KTP'),
                        ],
                      )
                    ],
                  ),
                ),
                FormInput(
                  maxLength: 16,
                  validator: validateRequired,
                  controller: id,
                  label: 'Nomor Identitas',
                  hint: 'Nomor Identitas',
                  keyboard: TextInputType.number,
                  icon: FontAwesomeIcons.idCard,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Text('$errorID', style: TextStyle(color: Colors.red)),
                ),
                FormInput(
                  validator: validateRequired,
                  controller: namaLengkap,
                  label: 'Nama Lengkap',
                  hint: 'Nama Lengkap',
                  icon: FontAwesomeIcons.userEdit,
                ),
                FormInput(
                  validator: validateRequired,
                  controller: tempatLahir,
                  label: 'Tempat Lahir',
                  hint: 'Tempat Lahir',
                  icon: FontAwesomeIcons.city,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.calendar),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: stglLahir == ''
                            ? Text('tanggal-bulan-tahun',
                                style: TextStyle(color: Colors.grey))
                            : Text(stglLahir),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Divider(color: Colors.black87),
                      ),
                      Text(
                        '$errorTglLahir',
                        style: TextStyle(fontSize: 12.5, color: Colors.red),
                      ),
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
                ListTile(
                  leading: Icon(FontAwesomeIcons.venusMars),
                  subtitle: Text(
                    '$errorJK',
                    style: TextStyle(fontSize: 12.5, color: Colors.red),
                  ),
                  title: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 'L',
                            groupValue: jk,
                            activeColor: Colors.amber,
                            onChanged: (String value) {
                              _pilihJK(value);
                            },
                          ),
                          Text('Laki-laki')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 'P',
                            groupValue: jk,
                            activeColor: Colors.amber,
                            onChanged: (String value) {
                              _pilihJK(value);
                            },
                          ),
                          Text('Perempuan')
                        ],
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.pray),
                  title: DropdownButton(
                    isExpanded: true,
                    onChanged: (String value) {
                      setState(() {
                        _agama = value;
                      });
                    },
                    value: _agama,
                    items: agama.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                FormInput(
                  controller: noTelp,
                  validator: validateRequired,
                  hint: '08xxxx',
                  label: 'No Telepon',
                  maxLength: 12,
                  keyboard: TextInputType.phone,
                  icon: FontAwesomeIcons.phoneAlt,
                ),
                TextArea(
                  validator: validateRequired,
                  controller: alamat,
                  hint: 'Alamat',
                  label: 'Alamat',
                  icon: FontAwesomeIcons.mapMarkedAlt,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {
                    if (formKey.currentState.validate() &&
                        tglLahir != '' &&
                        jk != '' &&
                        jenisID != '') {
                      setState(() {
                        _cekID = true;
                      });
                      AnggotaModel.cekID(id.text).then((value) {
                        if (value.status == false) {
                          setState(() {
                            _cekID = false;
                            errorID = value.pesan;
                          });
                        } else {
                          data['jenisID'] = jenisID;
                          data['id'] = id.text;
                          data['namaLengkap'] = namaLengkap.text;
                          data['tempatLahir'] = tempatLahir.text;
                          data['tglLahir'] = tglLahir;
                          data['agama'] = _agama;
                          data['jk'] = jk;
                          data['email'] = email.text;
                          data['noTelp'] = noTelp.text;
                          data['alamat'] = alamat.text;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterPage2(
                                    data: data,
                                  )));
                        }
                      });
                    } else {
                      setState(() {
                        if (jenisID == '') {
                          errorJenisID = 'Harus Dipilih';
                        } else {
                          errorJenisID = '';
                        }
                        if (tglLahir == '') {
                          errorTglLahir = 'Harus Dipilih';
                        } else {
                          errorTglLahir = '';
                        }
                        if (jk == '') {
                          errorJK = 'Harus Dipilih';
                        } else {
                          errorJK = '';
                        }
                      });
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.amber,
                  child: _cekID == false
                      ? Text('Selanjutnya')
                      : CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
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
