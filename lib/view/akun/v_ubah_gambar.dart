import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/model/Akun_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UbahPP extends StatefulWidget {
  @override
  _UbahPPState createState() => _UbahPPState();
}

class _UbahPPState extends State<UbahPP> {
  File _image;
  bool _prosesUpload = false;

  Future getImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    //final tempDir = await getTemporaryDirectory();
    //final path = tempDir.path;
    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImage = Img.copyResize(image, width: 500);
    var compress = imageFile
      ..writeAsBytesSync(Img.encodeJpg(smallerImage, quality: 85));
    setState(() {
      _image = compress;
    });
  }

  Future getImageCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = imageFile;
    });
  }

  void _pilihan() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            children: <Widget>[
              ListTile(
                leading: Icon(FontAwesomeIcons.image),
                title: Text('Browse Gambar'),
                onTap: () {
                  getImage();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.camera),
                title: Text('Kamera'),
                onTap: () {
                  getImageCamera();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(title: 'Ubah Gambar Profil'),
      drawer: Template(
        akun: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              height: 120.0,
              child: Center(
                child: _image == null
                    ? Text('No Image')
                    : Container(
                        height: 100,
                        width: 100,
                        child: Image.file(_image),
                      ),
              ),
            ),
            RaisedButton(
              onPressed: _pilihan,
              child: Text('Browse Gambar'),
            ),
            Builder(
              builder: (context) => RaisedButton(
                    onPressed: () {
                      if (_image == null) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Silahkan memilih gambar!')));
                      } else {
                        setState(() {
                          _prosesUpload = true;
                        });
                        AkunModel.changePP(_image).then((value) {
                          setState(() {
                            _prosesUpload = false;
                          });
                          Navigator.pop(context, value.pesan);
                        });
                      }
                    },
                    child: _prosesUpload == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Upload'),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child:
                                    Icon(FontAwesomeIcons.upload, size: 15.0),
                              )
                            ],
                          )
                        : CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.amber),
                          ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
