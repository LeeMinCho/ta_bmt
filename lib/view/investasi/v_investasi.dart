import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/view/v_template.dart';
import 'package:bmt_sahabat_umat/view/investasi/v_mudharabah.dart';

class Investasi extends StatelessWidget {
  static final String tag = 'Investasi';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: 'Investasi',
      ),
      drawer: Template(
        investasi: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => new Mudharabah()));
                },
                leading: Icon(
                  Icons.business,
                  size: 40.0,
                  color: Colors.blue,
                ),
                title: Text('Mudharabah'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
