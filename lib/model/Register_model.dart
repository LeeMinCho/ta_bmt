import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bmt_sahabat_umat/helper/url_helper.dart';

class RegisterModel {
  final String message;
  final bool status;
  RegisterModel({this.message, this.status});

  factory RegisterModel.fromJSON(Map<String, dynamic> obj) {
    return RegisterModel(message: obj['message'], status: obj['status']);
  }

  static Future<RegisterModel> insertPendaftaran(
      Map<String, dynamic> data) async {
    final response = await http.post(baseUrl('anggota/daftar'), body: {
      'id_identitas': data['id'],
      'jenis_identitas': data['jenisID'],
      'nama_lengkap': data['namaLengkap'],
      'tempat_lahir': data['tempatLahir'],
      'tgl_lahir': data['tglLahir'],
      'jenis_kelamin': data['jk'],
      'agama': data['agama'],
      'alamat': data['alamat'],
      'no_telp': data['noTelp'],
      'status_pernikahan': data['statusPernikahan'],
      'nama_pasangan': data['namaPasangan'],
      'nama_ibu_kandung': data['namaIbu'],
      'nama_ahli_waris': data['namaAhliWaris'],
      'hubungan_ahli_waris': data['hubunganAhliWaris'],
      'status_tempat_tinggal': data['statusRumah'],
      'pekerjaan': data['pekerjaan'],
      'pendidikan_terakhir': data['pendidikan'],
      'nama_alamat_kantor': data['kantor'],
      'penghasilan': data['gaji'],
      'jabatan': data['jabatan'],
      'simpanan_wajib': data['wajib'],
    });
    var jsonObject = json.decode(response.body);
    return RegisterModel.fromJSON(jsonObject);
  }
}
