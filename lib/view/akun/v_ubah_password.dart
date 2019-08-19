import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/model/Akun_model.dart';
import 'package:bmt_sahabat_umat/helper/form_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UbahPassword extends StatefulWidget {
  @override
  _UbahPasswordState createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController password = new TextEditingController();
  final TextEditingController konfPassword = new TextEditingController();
  bool _prosesUbah = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: 'Ubah Password',
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FormInput(
                controller: password,
                hint: 'Password',
                label: 'Password',
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Field ini harus diisi';
                  } else if (value.isEmpty && value.length < 8) {
                    return 'Password harus 8 karakter atau lebih';
                  } else if (value.isEmpty && isAlphanumeric(value) == false) {
                    return 'Password harus berupa angka dan huruf';
                  } else {
                    return null;
                  }
                },
                icon: FontAwesomeIcons.key,
              ),
              FormInput(
                controller: konfPassword,
                hint: 'Konfirmasi Password',
                label: 'Konfirmasi Password',
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Field ini harus diisi';
                  } else if (value.isEmpty && value != konfPassword.text) {
                    return 'Konfirmasi Password tidak cocok dengan password';
                  }
                },
                icon: FontAwesomeIcons.key,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: _prosesUbah == false
                    ? RaisedButton(
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text('Ubah Password',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            setState(() {
                              _prosesUbah = true;
                            });
                            AkunModel.changePassword(password.text)
                                .then((value) {
                              setState(() {
                                _prosesUbah = false;
                              });
                              Navigator.pop(context, value.pesan);
                            });
                          }
                        },
                      )
                    : CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
