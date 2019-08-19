import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:bmt_sahabat_umat/helper/url_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnggotaModel {
  final String idAnggota;
  final String idId;
  final String jenisId;
  final String namaLengkap;
  final String ttl;
  final String jk;
  final String agama;
  final String alamat;
  final String noTelp;
  final String email;
  final String statusPernikahan;
  final String namaPasangan;
  final String namaIbuKandung;
  final String namaAhliWaris;
  final String hubAhliWaris;
  final String statusTempatTinggal;
  final String pekerjaan;
  final String pendidikan;
  final String kantor;
  final String jabatan;
  final int penghasilan;
  final int saldoWajib;
  final String pesan;
  final bool status;
  final String foto;
  AnggotaModel(
      {this.idAnggota,
      this.idId,
      this.namaLengkap,
      this.ttl,
      this.agama,
      this.jk,
      this.alamat,
      this.noTelp,
      this.email,
      this.statusPernikahan,
      this.namaPasangan,
      this.namaIbuKandung,
      this.namaAhliWaris,
      this.hubAhliWaris,
      this.statusTempatTinggal,
      this.pekerjaan,
      this.pendidikan,
      this.kantor,
      this.jabatan,
      this.penghasilan,
      this.jenisId,
      this.saldoWajib,
      this.pesan,
      this.status,
      this.foto});

  factory AnggotaModel.getInfoUSer(Map<String, dynamic> obj) {
    return AnggotaModel(
      namaLengkap: obj['nama_lengkap'],
      saldoWajib: int.parse(obj['wajib']),
      idAnggota: obj['id_anggota'],
    );
  }

  factory AnggotaModel.getAkun(Map<String, dynamic> obj) {
    return AnggotaModel(
        jenisId: obj['jenis_identitas'],
        idId: obj['id_identitas'],
        namaLengkap: obj['nama_lengkap'],
        ttl: obj['tempat_lahir'] + ', ' + obj['tgl_lahir'],
        jk: obj['jenis_kelamin'],
        alamat: obj['alamat'],
        email: obj['email'],
        agama: obj['agama'],
        noTelp: obj['no_telp'],
        statusPernikahan: obj['status_pernikahan'],
        namaPasangan: obj['nama_pasangan'],
        namaIbuKandung: obj['nama_ibu_kandung'],
        namaAhliWaris: obj['nama_ahli_waris'],
        hubAhliWaris: obj['hubungan_ahli_waris'],
        statusTempatTinggal: obj['status_tempat_tinggal'],
        pekerjaan: obj['pekerjaan'],
        pendidikan: obj['pendidikan_terakhir'],
        kantor: obj['nama_alamat_kantor'],
        jabatan: obj['jabatan'],
        penghasilan: int.parse(obj['penghasilan']),
        foto: obj['foto']);
  }

  factory AnggotaModel.fromJSON(Map<String, dynamic> obj) {
    return AnggotaModel(status: obj['status'], pesan: obj['message']);
  }

  Future<AnggotaModel> fetchInfoUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(baseUrl('anggota/info_user'),
        body: {'id_anggota': pref.getString('idAnggota')});
    var jsonObject = json.decode(response.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    return AnggotaModel.getInfoUSer(data);
  }

  Future<AnggotaModel> fetchAkun() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(baseUrl('anggota'),
        body: {'id_anggota': pref.getString('idAnggota')});
    var jsonObject = json.decode(response.body);
    var data = (jsonObject as Map<String, dynamic>)['data'];
    return AnggotaModel.getAkun(data);
  }

  static Future<AnggotaModel> cekID(String id) async {
    final response =
        await http.post(baseUrl('anggota/id_validation'), body: {'id': id});
    var jsonObject = json.decode(response.body);
    return AnggotaModel.fromJSON(jsonObject);
  }
}
