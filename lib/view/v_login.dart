import 'package:bmt_sahabat_umat/model/Akun_model.dart';
import 'package:flutter/material.dart';
//import 'package:bmt_sahabat_umat/view/register/register_page_1.dart';
import 'package:bmt_sahabat_umat/view/register/register_page_1.dart';
import 'package:bmt_sahabat_umat/library/form_validation.dart';
import 'v_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'loginPage';
  final String pesan;
  LoginPage({this.pesan});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Validation {
  final formKey = GlobalKey<FormState>();
  final TextEditingController idAnggota = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  bool _prosesLogin = false;
  String _errorLogin = '';

  @override
  void initState() {
    super.initState();
    if (widget.pesan != null) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('${widget.pesan}')));
    }
  }

  void _panduan() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Center(child: Text('Panduan Pendaftaran Anggota')),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('1. Klik Tombol Pendaftaran Anggota'),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('2. Isi data-data yang diperlukan'),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('3. Datang ke kantor BMT untuk validasi'),
                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.amber,
                child: Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        });
  }

  Widget _buildPageContent() {
    return Container(
      //padding: EdgeInsets.all(20.0),
      color: Colors.grey.shade800,
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: 180.0,
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, top: 50.0),
              child: Column(
                children: <Widget>[
                  Image.asset('images/banner.jpg'),
                ],
              ),
            ),
          ),
          /* Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('images/banner.jpg'),
            ),
          ), */
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '$_errorLogin',
                        style: TextStyle(color: Colors.red),
                      ),
                      ListTile(
                          title: TextFormField(
                        validator: validateRequired,
                        controller: idAnggota,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "ID Anggota",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.white30,
                            )),
                      )),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                      ListTile(
                          title: TextFormField(
                        obscureText: true,
                        validator: validateRequired,
                        controller: password,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.white30,
                            )),
                      )),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  setState(() {
                                    _prosesLogin = true;
                                  });
                                  AkunModel.doLogin(
                                          idAnggota.text, password.text)
                                      .then((value) async {
                                    if (value.idAnggota.isNotEmpty) {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      pref.setString(
                                          'idAnggota', value.idAnggota);
                                      Navigator.pushReplacementNamed(
                                          context, Home.tag);
                                    } else {
                                      setState(() {
                                        _errorLogin = value.pesan;
                                        _prosesLogin = false;
                                      });
                                    }
                                  });
                                }
                              },
                              color: Colors.amber,
                              child: _prosesLogin == false
                                  ? Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    )
                                  : CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FlatButton(
                  onPressed: _panduan,
                  child: Text('Panduan Pendaftaran Anggota',
                      style: TextStyle(color: Colors.white)),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterPage1.tag);
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new Register())); */
                  },
                  child: Text(
                    'Pendaftaran Anggota',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(),
    );
  }
}
