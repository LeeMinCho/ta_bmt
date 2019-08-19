import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/view/register/register_page_3.dart';
import 'package:bmt_sahabat_umat/helper/form_helper.dart';
import 'package:bmt_sahabat_umat/library/form_validation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage2 extends StatefulWidget {
  static String tag = 'registerPage2';
  final data;
  RegisterPage2({this.data});
  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> with Validation {
  final formKey = GlobalKey<FormState>();
  String status = '';
  String errorStatus = '';
  final TextEditingController namaPasangan = new TextEditingController();
  final TextEditingController namaIbu = new TextEditingController();
  final TextEditingController namaWaris = new TextEditingController();
  final TextEditingController hubWaris = new TextEditingController();
  void _pilihStatus(value) {
    setState(() {
      status = value;
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
                  leading: Icon(FontAwesomeIcons.userFriends),
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                              value: 'Menikah',
                              groupValue: status,
                              activeColor: Colors.amber,
                              onChanged: (String value) {
                                _pilihStatus(value);
                              },
                            ),
                            Text('Menikah')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                              value: 'Belum Menikah',
                              groupValue: status,
                              activeColor: Colors.amber,
                              onChanged: (String value) {
                                _pilihStatus(value);
                              },
                            ),
                            Text('Belum Menikah')
                          ],
                        ),
                        Text(
                          '$errorStatus',
                          style: TextStyle(fontSize: 12.5, color: Colors.red),
                        )
                      ]),
                ),
                FormInput(
                  controller: namaPasangan,
                  hint: 'Nama Suami/Istri',
                  label: 'Nama Suami/Istri',
                  icon: FontAwesomeIcons.solidHeart,
                ),
                FormInput(
                  validator: validateRequired,
                  controller: namaIbu,
                  hint: 'Nama Ibu Kandung',
                  label: 'Nama Ibu Kandung',
                  icon: FontAwesomeIcons.female,
                ),
                FormInput(
                  controller: namaWaris,
                  hint: 'Nama Ahli Waris',
                  label: 'Nama Ahli Waris',
                  icon: FontAwesomeIcons.child,
                ),
                FormInput(
                  controller: hubWaris,
                  hint: 'Hubungan Ahli Waris',
                  label: 'Hubungan Ahli Waris',
                  icon: FontAwesomeIcons.child,
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
                    if (formKey.currentState.validate() && status != '') {
                      widget.data['statusPernikahan'] = status;
                      widget.data['namaPasangan'] = namaPasangan.text;
                      widget.data['namaIbu'] = namaIbu.text;
                      widget.data['namaAhliWaris'] = namaWaris.text;
                      widget.data['hubunganAhliWaris'] = hubWaris.text;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterPage3(
                                data: widget.data,
                              )));
                    } else {
                      setState(() {
                        if (errorStatus == '') {
                          errorStatus = 'Harus dipilih!';
                        } else {
                          errorStatus = '';
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
