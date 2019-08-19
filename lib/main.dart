import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_home.dart';
import 'package:bmt_sahabat_umat/view/v_login.dart';
import 'package:bmt_sahabat_umat/view/akun/v_akun.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bmt_sahabat_umat/view/simpanan/v_simpanan.dart';
import 'package:bmt_sahabat_umat/view/investasi/v_investasi.dart';
import 'package:bmt_sahabat_umat/view/pembiayaan/v_pembiayaan.dart';
import 'package:bmt_sahabat_umat/view/register/register_page_1.dart';

Future<void> main() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var idAnggota = pref.getString('idAnggota');

  runApp(MaterialApp(
    color: Colors.black,
    debugShowCheckedModeBanner: false,
    title: 'BMT Sahabat Umat',
    home: idAnggota == null ? LoginPage() : Home(),
    routes: <String, WidgetBuilder>{
      LoginPage.tag: (context) => new LoginPage(),
      Home.tag: (context) => new Home(),
      RegisterPage1.tag: (context) => new RegisterPage1(),
      Home.tag: (context) => new Home(),
      Akun.tag: (context) => new Akun(),
      Simpanan.tag: (context) => new Simpanan(),
      Investasi.tag: (context) => new Investasi(),
      Pembiayaan.tag: (context) => new Pembiayaan(),
    },
  ));
}
