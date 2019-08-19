import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:bmt_sahabat_umat/helper/url_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MudharabahModel {
  final String idInvestasi;
  final int besarInvestasi;
  final String tglSetor;
  final String nisbahBMT;
  final String nisbahAnggota;
  final String jangkaWaktu;
  final String klaster;
  final String message;
  final String idKlaster;
  MudharabahModel({
    this.idInvestasi = '',
    this.besarInvestasi = 0,
    this.tglSetor = '',
    this.nisbahBMT = '',
    this.nisbahAnggota = '',
    this.jangkaWaktu = '',
    this.klaster = '',
    this.idKlaster = '',
    this.message = '',
  });

  factory MudharabahModel.fromJSON(Map<String, dynamic> obj) {
    return MudharabahModel(
        idInvestasi: obj['id_investasi'],
        besarInvestasi: int.parse(obj['besar_investasi']),
        tglSetor: obj['tgl_setor'],
        nisbahBMT: obj['nisbah_bmt'] + '%',
        nisbahAnggota: obj['nisbah_anggota'] + '%',
        jangkaWaktu: obj['jangka_waktu'] + ' bulan',
        klaster: obj['tahun_klaster'] + '-' + obj['nama_klaster'],
        idKlaster: obj['id_klaster']);
  }

  factory MudharabahModel.fromJSON2(Map<String, dynamic> obj) {
    return MudharabahModel(message: obj['message']);
  }

  Future<List<MudharabahModel>> getInvestasi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(baseUrl('investasi_mudharabah'),
        body: {'id_anggota': pref.getString('idAnggota')});
    var jsonObject = json.decode(response.body);
    List<MudharabahModel> investasi = [];
    if (response.statusCode == 200) {
      List<dynamic> listInvestasi =
          (jsonObject as Map<String, dynamic>)['data'];
      for (var i = 0; i < listInvestasi.length; i++) {
        investasi.add(MudharabahModel.fromJSON(listInvestasi[i]));
      }
    } else {
      investasi.add(MudharabahModel.fromJSON2(jsonObject));
    }
    return investasi;
  }
}
