import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bmt_sahabat_umat/helper/url_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KlasterModel {
  final String idKlaster;
  final String klaster;
  final int nominalInvestasi;
  final int saldo;
  final String jangkaWaktu;
  final String message;
  KlasterModel(
      {this.idKlaster,
      this.klaster,
      this.nominalInvestasi,
      this.jangkaWaktu,
      this.saldo = 0,
      this.message = ''});

  factory KlasterModel.fromJSON(Map<String, dynamic> obj) {
    int nominalInvestasi = int.parse(obj['nominal_investasi']);
    return KlasterModel(
        idKlaster: obj['id_klaster'],
        klaster: obj['tahun_klaster'] + '-' + obj['nama_klaster'],
        nominalInvestasi: nominalInvestasi,
        jangkaWaktu: obj['jangka_waktu'] + ' bulan',
        saldo: nominalInvestasi - int.parse(obj['penggunaan']));
  }

  factory KlasterModel.fromJSON2(Map<String, dynamic> obj) {
    return KlasterModel(message: obj['message']);
  }

  Future<List<KlasterModel>> getKlaster() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(baseUrl('klaster'),
        body: {'id_anggota': pref.getString('idAnggota')});
    var jsonObject = json.decode(response.body);
    List<KlasterModel> klaster = [];
    if (response.statusCode == 200) {
      List<dynamic> listKlaster = (jsonObject as Map<String, dynamic>)['data'];
      for (var i = 0; i < listKlaster.length; i++) {
        klaster.add(KlasterModel.fromJSON(listKlaster[i]));
      }
    } else {
      klaster.add(KlasterModel.fromJSON2(jsonObject));
    }
    return klaster;
  }
}
