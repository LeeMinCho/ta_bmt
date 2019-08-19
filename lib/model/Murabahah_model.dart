import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:bmt_sahabat_umat/helper/url_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MurabahahModel {
  /* insertPengajuan(var data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    http.post(baseUrl('murabahah/pengajuan'), body: {
      'estimasi_harga': data['estimasi_harga'],
      'item_murabahah': data['item_murabahah'],
      'jangka_waktu': data['jangka_waktu'],
      'kesanggupan_cicilan': data['kesanggupan_cicilan'],
      'jaminan': data['jaminan'],
      'uang_muka': data['uang_muka'],
      'id_anggota': pref.getString('idAnggota').toString()
    });
  } */
  final String idMurabahah;
  final int estimasiHarga;
  final int kesanggupanCicilan;
  final String tglPengajuan;
  final int statusPengajuan;
  final int besarMurabahah;
  final int pokok;
  final int margin;
  final int cicilanPokok;
  final int cicilanMargin;
  final int totalCicilan;
  final String jangkaWaktu;
  final int ketMurabahah;
  final int saldoPokok;
  final int saldoCicilan;
  final String itemMurabahah;
  final String jaminan;
  final int uangMuka;
  final String tglAkad;
  final String message;
  MurabahahModel(
      {this.message = '',
      this.idMurabahah,
      this.estimasiHarga,
      this.kesanggupanCicilan,
      this.tglPengajuan,
      this.statusPengajuan,
      this.besarMurabahah,
      this.pokok,
      this.margin,
      this.cicilanPokok,
      this.cicilanMargin,
      this.totalCicilan,
      this.jangkaWaktu,
      this.ketMurabahah,
      this.saldoPokok,
      this.saldoCicilan,
      this.itemMurabahah,
      this.jaminan,
      this.uangMuka,
      this.tglAkad});

  factory MurabahahModel.fromJSON(Map<String, dynamic> obj) {
    return MurabahahModel(
      idMurabahah: obj['id_murabahah'],
      estimasiHarga: int.parse(obj['estimasi_harga']),
      kesanggupanCicilan: int.parse(obj['kesanggupan_cicilan']),
      tglPengajuan: obj['tgl_p_murabahah'],
      statusPengajuan: int.parse(obj['status_p_murabahah']),
      besarMurabahah: int.parse(obj['besar_murabahah']),
      pokok: int.parse(obj['pokok']),
      margin: int.parse(obj['margin']),
      cicilanPokok: int.parse(obj['cicilan_pokok']),
      cicilanMargin: int.parse(obj['cicilan_margin']),
      totalCicilan: int.parse(obj['total_cicilan']),
      jangkaWaktu: obj['jangka_waktu'] + ' bulan',
      ketMurabahah: int.parse(obj['keterangan_murabahah']),
      saldoPokok: int.parse(obj['saldo_pokok']),
      saldoCicilan: int.parse(obj['saldo_cicilan']),
      itemMurabahah: obj['item_murabahah'],
      jaminan: obj['jaminan'],
      uangMuka: int.parse(obj['uang_muka']),
      tglAkad: obj['tgl_akad'],
    );
  }

  factory MurabahahModel.fromJSON2(Map<String, dynamic> obj) {
    return MurabahahModel(message: obj['message']);
  }

  factory MurabahahModel.fromJSON3(Map<String, dynamic> obj) {
    return MurabahahModel(
        idMurabahah: obj['id_murabahah'],
        estimasiHarga: int.parse(obj['estimasi_harga']),
        kesanggupanCicilan: int.parse(obj['kesanggupan_cicilan']),
        tglPengajuan: obj['tgl_p_murabahah'],
        statusPengajuan: int.parse(obj['status_p_murabahah']),
        besarMurabahah: int.parse(obj['besar_murabahah']),
        jangkaWaktu: obj['jangka_waktu'],
        itemMurabahah: obj['item_murabahah'],
        jaminan: obj['jaminan'],
        uangMuka: int.parse(obj['uang_muka']));
  }

  Future<List<MurabahahModel>> getMurabahah() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(baseUrl('murabahah/riwayat_murabahah'),
        body: {'id_anggota': pref.getString('idAnggota')});
    var jsonObject = json.decode(response.body);
    List<MurabahahModel> murabahah = [];
    if (response.statusCode == 200) {
      List<dynamic> listMurabahah =
          (jsonObject as Map<String, dynamic>)['data'];
      for (var i = 0; i < listMurabahah.length; i++) {
        murabahah.add(MurabahahModel.fromJSON(listMurabahah[i]));
      }
    } else {
      murabahah.add(MurabahahModel.fromJSON2(jsonObject));
    }
    return murabahah;
  }

  Future<List<MurabahahModel>> getPengajuan() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(baseUrl('murabahah/riwayat_pengajuan'),
        body: {'id_anggota': pref.getString('idAnggota')});
    var jsonObject = json.decode(response.body);
    List<MurabahahModel> pengajuan = [];
    if (response.statusCode == 200) {
      List<dynamic> listPengajuan =
          (jsonObject as Map<String, dynamic>)['data'];
      for (var i = 0; i < listPengajuan.length; i++) {
        pengajuan.add(MurabahahModel.fromJSON3(listPengajuan[i]));
      }
    } else {
      pengajuan.add(MurabahahModel.fromJSON2(jsonObject));
    }
    return pengajuan;
  }

  static Future<MurabahahModel> insertPengajuan(
      Map<String, dynamic> data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(baseUrl('murabahah/pengajuan'), body: {
      'estimasi_harga': data['estimasi_harga'],
      'item_murabahah': data['item_murabahah'],
      'jangka_waktu': data['jangka_waktu'],
      'kesanggupan_cicilan': data['kesanggupan_cicilan'],
      'jaminan': data['jaminan'],
      'uang_muka': data['uang_muka'],
      'id_anggota': pref.getString('idAnggota').toString()
    });
    var jsonObject = json.decode(response.body);
    return MurabahahModel.fromJSON2(jsonObject);
  }
}
