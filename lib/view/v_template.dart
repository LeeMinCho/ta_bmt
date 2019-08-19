import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/simpanan/v_simpanan.dart';
import 'package:bmt_sahabat_umat/view/investasi/v_investasi.dart';
import 'package:bmt_sahabat_umat/view/pembiayaan/v_pembiayaan.dart';
import 'v_home.dart';
import 'v_login.dart';
import 'akun/v_akun.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Template extends StatefulWidget {
  final bool beranda;
  final bool simpanan;
  final bool investasi;
  final bool pembiayaan;
  final bool produk;
  final bool akun;
  Template(
      {this.beranda = false,
      this.simpanan = false,
      this.investasi = false,
      this.pembiayaan = false,
      this.produk = false,
      this.akun = false});
  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  String _idAnggota;
  Future<String> _getAkun() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _idAnggota = pref.getString('idAnggota');
    });
    return _idAnggota;
  }

  @override
  void initState() {
    super.initState();
    _getAkun();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(accentColor: Colors.amber),
      child: Drawer(
        child: new ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_idAnggota != null ? _idAnggota : ''),
              accountEmail: Text(''),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/KR_Shinobi.png')),
            ),
            ListTile(
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(Home.tag);
              },
              title: Text('Beranda'),
              trailing: Icon(Icons.home),
              selected: widget.beranda,
            ),
            ListTile(
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(Simpanan.tag);
              },
              title: Text('Simpanan'),
              trailing: Icon(Icons.monetization_on),
              selected: widget.simpanan,
            ),
            ListTile(
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(Investasi.tag);
              },
              title: Text('Investasi'),
              trailing: Icon(Icons.show_chart),
              selected: widget.investasi,
            ),
            ListTile(
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(Pembiayaan.tag);
              },
              title: Text('Pembiayaan'),
              trailing: Icon(Icons.insert_chart),
              selected: widget.pembiayaan,
            ),
            ListTile(
              onTap: () {
                //Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(Akun.tag);
              },
              title: Text('Akun'),
              trailing: Icon(Icons.person),
              selected: widget.akun,
            ),
            Divider(),
            ListTile(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('idAnggota');
                Navigator.of(context).pushReplacementNamed(LoginPage.tag);
              },
              title: Text('Log Out'),
              trailing: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarTemplate extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  AppBarTemplate({@required this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
      backgroundColor: Colors.grey[900],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AppBarRegister extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Form Pendaftaran Anggota'),
      backgroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
