import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bmt_sahabat_umat/helper/url_helper.dart';

class AngsuranModel {
  final int bayarPokok;
  final int bayarMargin;
  final int potongan;
  final int totalBayar;
  final String angsuranKe;
  final tglWajib;
  final tglBayar;
  final int statusAngsuran;
  final String message;
  AngsuranModel(
      {this.bayarPokok,
      this.bayarMargin,
      this.potongan,
      this.totalBayar,
      this.angsuranKe,
      this.tglWajib,
      this.tglBayar,
      this.statusAngsuran,
      this.message = ''});

  factory AngsuranModel.fromJSON(Map<String, dynamic> obj) {
    return AngsuranModel(
      bayarPokok: int.parse(obj['bayar_pokok']),
      bayarMargin: int.parse(obj['bayar_margin']),
      potongan: int.parse(obj['potongan']),
      totalBayar: int.parse(obj['total_bayar']),
      angsuranKe: obj['angsuran_murabahah_ke'],
      tglWajib: obj['tgl_wajib'],
      tglBayar: obj['tgl_bayar'],
      statusAngsuran: int.parse(obj['status_angsuran']),
    );
  }

  factory AngsuranModel.fromJSON2(Map<String, dynamic> obj) {
    return AngsuranModel(message: obj['message']);
  }

  Future<List<AngsuranModel>> getAngsuran(String idMurabahah) async {
    final response = await http.post(baseUrl('murabahah/angsuran'),
        body: {'id_murabahah': idMurabahah});
    var jsonObject = json.decode(response.body);
    List<AngsuranModel> angsuran = [];
    if (response.statusCode == 200) {
      List<dynamic> listAngsuran = (jsonObject as Map<String, dynamic>)['data'];
      for (var i = 0; i < listAngsuran.length; i++) {
        angsuran.add(AngsuranModel.fromJSON(listAngsuran[i]));
      }
    } else {
      angsuran.add(AngsuranModel.fromJSON2(jsonObject));
    }
    return angsuran;
  }
}
