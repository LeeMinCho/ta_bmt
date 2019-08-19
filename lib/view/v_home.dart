import 'package:flutter/material.dart';
import 'package:indonesia/indonesia.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/view/akun/v_akun.dart';
import 'package:bmt_sahabat_umat/model/Anggota_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmt_sahabat_umat/view/simpanan/v_simpanan.dart';
import 'package:bmt_sahabat_umat/view/investasi/v_investasi.dart';
import 'package:bmt_sahabat_umat/view/pembiayaan/v_pembiayaan.dart';
import 'package:bmt_sahabat_umat/vendor/iampawan/dashboard_menu_row_two.dart';
import 'package:sliver_fill_remaining_box_adapter/sliver_fill_remaining_box_adapter.dart';

class Home extends StatefulWidget {
  static String tag = 'Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<AnggotaModel> infoUser;
  AnggotaModel _anggotaModel = new AnggotaModel();

  @override
  void initState() {
    super.initState();
    infoUser = _anggotaModel.fetchInfoUser();
  }

  Widget bodyData() => CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.black,
          pinned: true,
          expandedHeight: 180.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: kToolbarHeight),
                child: Image.asset('images/banner.jpg')),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          sliver: SliverFillRemainingBoxAdapter(
            child: FutureBuilder<AnggotaModel>(
              future: infoUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                          color: Colors.black,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                FontAwesomeIcons.idCard,
                                color: Colors.black,
                              ),
                            ),
                            title: Text(
                              snapshot.data.namaLengkap,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              snapshot.data.idAnggota,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      DashboardMenuRowTwo(
                        firstIcon: FontAwesomeIcons.handHoldingUsd,
                        firstCircleColor: Colors.black87,
                        firstLabel: "Simpanan",
                        firstOnPressed: () {
                          Navigator.pushNamed(context, Simpanan.tag);
                        },
                        secondIcon: FontAwesomeIcons.fileInvoiceDollar,
                        secondCircleColor: Colors.black87,
                        secondLabel: "Investasi",
                        secondOnPressed: () {
                          Navigator.pushNamed(context, Investasi.tag);
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      DashboardMenuRowTwo(
                        firstIcon: FontAwesomeIcons.moneyBillAlt,
                        firstCircleColor: Colors.black87,
                        firstLabel: "Pembiayaan",
                        firstOnPressed: () {
                          Navigator.pushNamed(context, Pembiayaan.tag);
                        },
                        secondIcon: FontAwesomeIcons.user,
                        secondCircleColor: Colors.black87,
                        secondLabel: "Akun",
                        secondOnPressed: () {
                          Navigator.pushNamed(context, Akun.tag);
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 2.0,
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.coins,
                              color: Colors.green,
                            ),
                            title: Text('Saldo Simpanan Wajib'),
                            subtitle: Text(rupiah(snapshot.data.saldoWajib,
                                trailing: ',00')),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      drawer: Template(
        beranda: true,
      ),
      body: bodyData(),
    );
  }
}
