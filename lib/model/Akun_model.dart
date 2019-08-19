import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:bmt_sahabat_umat/helper/url_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunModel {
  final String idAnggota;
  final String pesan;
  AkunModel({this.pesan, this.idAnggota});

  factory AkunModel.getAkun(Map<String, dynamic> object) {
    return AkunModel(idAnggota: object['id_anggota']);
  }

  factory AkunModel.gagalLogin(Map<String, dynamic> object) {
    return AkunModel(idAnggota: '', pesan: object['message']);
  }

  factory AkunModel.fromJSON(Map<String, dynamic> object) {
    return AkunModel(pesan: object['message']);
  }

  static Future<AkunModel> doLogin(String idAnggota, String password) async {
    var userData = await http.post(baseUrl('auth'),
        body: {'id_anggota': idAnggota, 'password': password});
    var jsonResult = json.decode(userData.body);
    if (userData.statusCode == 200) {
      return AkunModel.getAkun(jsonResult['data']);
    } else {
      return AkunModel.gagalLogin(jsonResult);
    }
  }

  static Future<AkunModel> changePassword(String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.put(baseUrl('auth/ubah_password'), body: {
      'id_anggota': pref.getString('idAnggota'),
      'password': password
    });
    var jsonObject = json.decode(response.body);
    return AkunModel.fromJSON(jsonObject);
  }

  static Future<AkunModel> changePP(File imageFile) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(baseUrl('Upload_gambar/ubah_pp'));
    var request = http.MultipartRequest('POST', uri);
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    request.fields['id_anggota'] = pref.getString('idAnggota');
    request.files.add(multipartFile);
    var response = await request.send();
    Map<String, String> data = Map();
    if (response.statusCode == 200) {
      data['message'] = 'Upload Berhasil!';
    } else {
      data['message'] = 'Upload Gagal!';
    }
    return AkunModel.fromJSON(data);
  }
}
