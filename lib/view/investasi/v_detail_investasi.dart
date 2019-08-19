import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:indonesia/indonesia.dart';
import 'package:bmt_sahabat_umat/model/Mudharabah_model.dart';
import 'package:bmt_sahabat_umat/model/Nisbah_investasi_model.dart';

class DetailInvestasi extends StatefulWidget {
  final MudharabahModel detail;
  DetailInvestasi({this.detail});
  @override
  _DetailInvestasiState createState() => _DetailInvestasiState();
}

class _DetailInvestasiState extends State<DetailInvestasi> {
  Future<List<NisbahInvestasiModel>> listNisbah;
  NisbahInvestasiModel _nisbahInvestasi = new NisbahInvestasiModel();

  @override
  void initState() {
    super.initState();
    listNisbah = _nisbahInvestasi.getNisbah(widget.detail.idInvestasi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: widget.detail.idInvestasi,
      ),
      body: Scrollbar(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('INVESTASI MUDHARABAH',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 8.0,
                        ),
                        Konten(
                          title: 'Besar Investasi',
                          item: rupiah(widget.detail.besarInvestasi,
                              trailing: ',00'),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Konten(
                          title: 'Tanggal Setor',
                          item: tanggal(DateTime.parse(widget.detail.tglSetor)),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Konten(
                          title: 'Jangka Waktu',
                          item: widget.detail.jangkaWaktu,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Konten(
                          title: 'Nisbah BMT',
                          item: widget.detail.nisbahBMT,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Konten(
                          title: 'Nisbah Anggota',
                          item: widget.detail.nisbahAnggota,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        widget.detail.idKlaster != ''
                            ? Konten(
                                title: 'Klaster',
                                item: widget.detail.klaster,
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FutureBuilder(
                future: listNisbah,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Card(
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('BAGI HASIL',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Divider(),
                            ListNisbah(
                              list: snapshot.data,
                            ),
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
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListNisbah extends StatelessWidget {
  final List<NisbahInvestasiModel> list;
  ListNisbah({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        if (list[i].message == null) {
          return Container(
            child: Card(
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(list[i].tahun),
                    subtitle: Text(rupiah(list[i].nisbah, trailing: ',00')),
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(
              child: Text(list[i].message,
                  style:
                      TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic)));
        }
      },
    );
  }
}

class Konten extends StatelessWidget {
  const Konten({
    Key key,
    @required this.title,
    @required this.item,
  }) : super(key: key);

  final String title;
  final String item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 15.0, color: Colors.grey[700])),
        Text(item,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300))
      ],
    );
  }
}
