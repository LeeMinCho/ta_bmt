import 'package:bmt_sahabat_umat/view/pembiayaan/v_murabahah.dart';
import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';

class Pembiayaan extends StatelessWidget {
  static final String tag = 'Pembiayaan';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: 'Pembiayaan',
      ),
      drawer: Template(
        pembiayaan: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => new Murabahah(),
                  ));
                },
                leading: Icon(
                  Icons.shop,
                  size: 40.0,
                  color: Colors.blueAccent,
                ),
                title: Text('Murabahah'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
