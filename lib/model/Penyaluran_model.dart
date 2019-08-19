import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bmt_sahabat_umat/helper/url_helper.dart';

class PenyaluranModel {
  final String idMurabahah;
  final String namaLengkap;
  final int besarMurabahah;
  final int pokok;
  final int margin;
  final int uangMuka;
  PenyaluranModel({
    this.idMurabahah,
    this.namaLengkap,
    this.besarMurabahah,
    this.pokok,
    this.margin,
    this.uangMuka,
  });

  factory PenyaluranModel.fromJSON(Map<String, dynamic> obj) {
    return PenyaluranModel(
      idMurabahah: obj['id_murabahah'],
      namaLengkap: obj['nama_lengkap'],
      besarMurabahah: int.parse(obj['besar_murabahah']),
      pokok: int.parse(obj['pokok']),
      margin: int.parse(obj['margin']),
      uangMuka: int.parse(obj['uang_muka']),
    );
  }

  Future<List<PenyaluranModel>> getPenyaluran(String idKlaster) async {
    final response = await http
        .post(baseUrl('klaster/penyaluran'), body: {'id_klaster': idKlaster});
    var jsonObject = json.decode(response.body);
    List<PenyaluranModel> penyaluran = [];
    List<dynamic> listPenyaluran = (jsonObject as Map<String, dynamic>)['data'];
    for (var i = 0; i < listPenyaluran.length; i++) {
      penyaluran.add(PenyaluranModel.fromJSON(listPenyaluran[i]));
    }
    return penyaluran;
  }
}
