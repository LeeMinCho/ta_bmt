import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bmt_sahabat_umat/helper/url_helper.dart';

class DetailKlasterModel {
  final String idInvestasi;
  final String nama;
  final String porsiBasil;
  final int besarInvestasi;
  DetailKlasterModel(
      {this.idInvestasi, this.nama, this.porsiBasil, this.besarInvestasi});

  factory DetailKlasterModel.fromJSON(Map<String, dynamic> obj) {
    return DetailKlasterModel(
        idInvestasi: obj['id_investasi'],
        nama: obj['nama_lengkap'],
        porsiBasil: obj['porsi_basil_persen'] + '%',
        besarInvestasi: int.parse(obj['besar_investasi']));
  }

  Future<List<DetailKlasterModel>> getDetailKlaster(String idKlaster) async {
    final response = await http.post(baseUrl('klaster/detail_klaster'),
        body: {'id_klaster': idKlaster});
    var jsonObject = json.decode(response.body);
    List<DetailKlasterModel> investor = [];
    if (response.statusCode == 200) {
      List<dynamic> listInvestor = (jsonObject as Map<String, dynamic>)['data'];
      for (var i = 0; i < listInvestor.length; i++) {
        investor.add(DetailKlasterModel.fromJSON(listInvestor[i]));
      }
    } else {
      investor.add(jsonObject);
    }
    return investor;
  }
}
