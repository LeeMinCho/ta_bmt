import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bmt_sahabat_umat/helper/url_helper.dart';

class NisbahInvestasiModel {
  final String tahun;
  final int nisbah;
  final int statusTerima;
  final DateTime tglTerima;
  final String message;
  NisbahInvestasiModel(
      {this.tahun,
      this.nisbah,
      this.statusTerima,
      this.tglTerima,
      this.message});

  factory NisbahInvestasiModel.fromJSON(Map<String, dynamic> obj) {
    return NisbahInvestasiModel(
      tahun: obj['tahun_nisbah'],
      nisbah: int.parse(obj['nominal_nisbah']),
      statusTerima: int.parse(obj['status_diterima']),
      tglTerima: DateTime.parse(obj['tgl_diterima']),
    );
  }

  factory NisbahInvestasiModel.fromJSON2(Map<String, dynamic> obj) {
    return NisbahInvestasiModel(message: obj['message']);
  }

  Future<List<NisbahInvestasiModel>> getNisbah(String idInvestasi) async {
    final response = await http.post(baseUrl('investasi_mudharabah/bagi_hasil'),
        body: {'id_investasi': idInvestasi});
    var jsonObject = json.decode(response.body);
    List<NisbahInvestasiModel> nisbahInvestasi = [];
    if (response.statusCode == 200) {
      List<dynamic> listNisbahInvestasi =
          (jsonObject as Map<String, dynamic>)['data'];
      for (var i = 0; i < listNisbahInvestasi.length; i++) {
        nisbahInvestasi
            .add(NisbahInvestasiModel.fromJSON(listNisbahInvestasi[i]));
      }
    } else {
      nisbahInvestasi.add(NisbahInvestasiModel.fromJSON2(jsonObject));
    }
    return nisbahInvestasi;
  }
}
