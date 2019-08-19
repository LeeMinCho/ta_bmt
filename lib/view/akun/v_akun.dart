import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/helper/url_helper.dart';
import 'package:bmt_sahabat_umat/model/Anggota_model.dart';
import 'package:bmt_sahabat_umat/view/akun/v_ubah_gambar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmt_sahabat_umat/view/akun/v_ubah_password.dart';

enum AkunPage { ubahPassword, ubahPP }

class Akun extends StatefulWidget {
  static String tag = 'Akun';
  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  Future<AnggotaModel> akunAnggota;
  AnggotaModel _anggota = new AnggotaModel();

  @override
  void initState() {
    super.initState();
    akunAnggota = _anggota.fetchAkun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Akun'),
        actions: <Widget>[
          Builder(
            builder: (context) => PopupMenuButton<AkunPage>(
                  onSelected: (AkunPage value) async {
                    switch (value) {
                      case AkunPage.ubahPassword:
                        var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new UbahPassword()));
                        Scaffold.of(context).removeCurrentSnackBar();
                        if (result != null) {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text('$result')));
                        }
                        break;
                      case AkunPage.ubahPP:
                        var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new UbahPP()));
                        Scaffold.of(context).removeCurrentSnackBar();
                        if (result != null) {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text('$result')));
                        }
                        break;
                    }
                  },
                  itemBuilder: (context) => <PopupMenuEntry<AkunPage>>[
                        PopupMenuItem<AkunPage>(
                          value: AkunPage.ubahPassword,
                          child: ListTile(
                            leading: Icon(FontAwesomeIcons.key),
                            title: Text('Ubah Password'),
                          ),
                        ),
                        PopupMenuItem<AkunPage>(
                          value: AkunPage.ubahPP,
                          child: ListTile(
                            leading: Icon(FontAwesomeIcons.image),
                            title: Text('Ubah Gambar Profil'),
                          ),
                        ),
                      ],
                ),
          ),
        ],
      ),
      drawer: Template(
        akun: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            color: Colors.black,
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'images/banner.jpg',
            ),
          ),
          FutureBuilder<AnggotaModel>(
              future: akunAnggota,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 150.0, 10.0, 10.0),
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Card(
                                elevation: 2.0,
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  margin: EdgeInsets.only(top: 16.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 96.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data.namaLengkap,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .title,
                                            ),
                                            ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              title: Text("Anggota"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                        image: NetworkImage(assetUrl(
                                            'uploads/images/users/${snapshot.data.foto}')),
                                        fit: BoxFit.cover)),
                                margin: EdgeInsets.only(left: 16.0),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Card(
                            elevation: 2.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Biodata Anggota'),
                                  ),
                                  Divider(),
                                  ListTile(
                                    title: Text("Jenis Identitas"),
                                    subtitle: Text(snapshot.data.jenisId),
                                    leading: Icon(FontAwesomeIcons.idCard),
                                  ),
                                  ListTile(
                                    title: Text("Tempat, tanggal lahir"),
                                    subtitle: Text(snapshot.data.ttl),
                                    leading:
                                        Icon(FontAwesomeIcons.birthdayCake),
                                  ),
                                  ListTile(
                                      title: Text("Jenis Kelamin"),
                                      subtitle: Text(snapshot.data.jk),
                                      leading:
                                          Icon(FontAwesomeIcons.venusMars)),
                                  ListTile(
                                    title: Text("Agama"),
                                    subtitle: Text(snapshot.data.agama),
                                    leading: Icon(FontAwesomeIcons.pray),
                                  ),
                                  ListTile(
                                    title: Text("Alamat"),
                                    subtitle: Text(snapshot.data.alamat),
                                    leading:
                                        Icon(FontAwesomeIcons.mapMarkedAlt),
                                  ),
                                  ListTile(
                                    title: Text("Email"),
                                    subtitle: Text(snapshot.data.email),
                                    leading: Icon(Icons.email),
                                  ),
                                  ListTile(
                                    title: Text("No. Telepon"),
                                    subtitle: Text(snapshot.data.noTelp),
                                    leading: Icon(Icons.phone),
                                  ),
                                  ListTile(
                                    title: Text("Joined Date"),
                                    subtitle: Text("15 February 2019"),
                                    leading:
                                        Icon(FontAwesomeIcons.fileSignature),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Card(
                            elevation: 2.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Status Keluarga'),
                                  ),
                                  Divider(),
                                  ListTile(
                                    title: Text("Status Pernikahan"),
                                    subtitle:
                                        Text(snapshot.data.statusPernikahan),
                                    leading: Icon(FontAwesomeIcons.ring),
                                  ),
                                  ListTile(
                                    title: Text("Nama Pasangan"),
                                    subtitle: Text(snapshot.data.namaPasangan),
                                    leading: Icon(FontAwesomeIcons.heart),
                                  ),
                                  ListTile(
                                      title: Text("Nama Ibu Kandung"),
                                      subtitle:
                                          Text(snapshot.data.namaIbuKandung),
                                      leading: Icon(FontAwesomeIcons.female)),
                                  ListTile(
                                    title: Text("Nama Ahli Waris"),
                                    subtitle: Text(snapshot.data.namaAhliWaris),
                                    leading: Icon(FontAwesomeIcons.userCheck),
                                  ),
                                  ListTile(
                                    title: Text("Hubungan Ahli Waris"),
                                    subtitle: Text(snapshot.data.hubAhliWaris),
                                    leading: Icon(FontAwesomeIcons.userCheck),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Card(
                            elevation: 2.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('Status Ekonomi'),
                                  ),
                                  Divider(),
                                  ListTile(
                                    title: Text("Status Tempat Tinggal"),
                                    subtitle:
                                        Text(snapshot.data.statusTempatTinggal),
                                    leading: Icon(FontAwesomeIcons.home),
                                  ),
                                  ListTile(
                                    title: Text("Pekerjaan"),
                                    subtitle: Text(snapshot.data.pekerjaan),
                                    leading: Icon(FontAwesomeIcons.toolbox),
                                  ),
                                  ListTile(
                                      title: Text("Pendidikan Terakhir"),
                                      subtitle: Text(snapshot.data.pendidikan),
                                      leading:
                                          Icon(FontAwesomeIcons.userGraduate)),
                                  ListTile(
                                    title: Text("Kantor"),
                                    subtitle: Text(snapshot.data.kantor),
                                    leading: Icon(FontAwesomeIcons.building),
                                  ),
                                  ListTile(
                                    title: Text("Jabatan"),
                                    subtitle: Text(snapshot.data.jabatan),
                                    leading: Icon(FontAwesomeIcons.briefcase),
                                  ),
                                  ListTile(
                                    title: Text("Penghasilan"),
                                    subtitle: Text(rupiah(
                                        snapshot.data.penghasilan,
                                        trailing: ',00')),
                                    leading:
                                        Icon(FontAwesomeIcons.commentDollar),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.amber)),
                  );
                }
              }),
        ],
      ),
    );
  }
}
