import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bmt_sahabat_umat/helper/url_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimpananModel {
  final int besarSimpanan;
  final String tglTransaksi;
  final String jenisSimpanan;
  final String message;
  SimpananModel(
      {this.besarSimpanan = 0,
      this.tglTransaksi = '',
      this.jenisSimpanan = '',
      this.message = ''});

  factory SimpananModel.fromJSON(Map<String, dynamic> obj) {
    return SimpananModel(
        besarSimpanan: int.parse(obj['besar_simpanan']),
        tglTransaksi: obj['tgl_transaksi'],
        jenisSimpanan: obj['jenis_simpanan']);
  }

  factory SimpananModel.fromJSON2(Map<String, dynamic> obj) {
    return SimpananModel(message: obj['message']);
  }

  Future<List<SimpananModel>> getSimpanan() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(baseUrl('simpanan'),
        body: {'id_anggota': pref.getString('idAnggota')});
    var jsonObject = json.decode(response.body);
    List<SimpananModel> simpanan = [];
    if (response.statusCode == 200) {
      List<dynamic> listSimpanan = (jsonObject as Map<String, dynamic>)['data'];
      for (var i = 0; i < listSimpanan.length; i++) {
        simpanan.add(SimpananModel.fromJSON(listSimpanan[i]));
      }
    } else {
      simpanan.add(SimpananModel.fromJSON2(jsonObject));
    }
    return simpanan;
  }

  static Future<List<SimpananModel>> getLaporan(String tahun) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(baseUrl('simpanan/download'),
        body: {'id_anggota': pref.getString('idAnggota'), 'tahun': tahun});
    var jsonObject = json.decode(response.body);
    List<SimpananModel> laporan = [];
    if (response.statusCode == 200) {
      List<dynamic> listLaporan = (jsonObject as Map<String, dynamic>)['data'];
      for (var i = 0; i < listLaporan.length; i++) {
        laporan.add(SimpananModel.fromJSON(listLaporan[i]));
      }
    } else {
      laporan.add(SimpananModel.fromJSON2(jsonObject));
    }
    return laporan;
  }
}
