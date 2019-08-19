import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/vendor/iampawan/label_below_icon.dart';

class DashboardMenuRowTwo extends StatelessWidget {
  final firstLabel;
  final IconData firstIcon;
  final firstOnPressed;
  final Color firstCircleColor;
  final secondLabel;
  final IconData secondIcon;
  final secondOnPressed;
  final Color secondCircleColor;
  /* final thirdLabel;
  final IconData thirdIcon; */

  const DashboardMenuRowTwo(
      {Key key,
      this.firstLabel,
      this.firstIcon,
      this.firstOnPressed,
      this.firstCircleColor,
      this.secondLabel,
      this.secondIcon,
      this.secondOnPressed,
      this.secondCircleColor
      /* this.thirdLabel,
    this.thirdIcon, */
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Size deviceSize = MediaQuery.of(context).size;
    double widthDevice = MediaQuery.of(context).size.width - 8.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox.fromSize(
            size: Size.square(widthDevice / 2.2),
            child: Card(
              elevation: 2.0,
              color: Colors.white,
              child: LabelBelowIcon(
                onPressed: firstOnPressed,
                betweenHeight: 15.0,
                icon: firstIcon,
                label: firstLabel,
                circleColor: firstCircleColor,
                iconColor: Colors.white,
                isCircleEnabled: true,
                radiusSize: 25.0,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox.fromSize(
            size: Size.square(widthDevice / 2.2),
            child: Card(
              elevation: 2.0,
              color: Colors.white,
              child: LabelBelowIcon(
                onPressed: secondOnPressed,
                betweenHeight: 15.0,
                icon: secondIcon,
                label: secondLabel,
                circleColor: secondCircleColor,
                iconColor: Colors.white,
                isCircleEnabled: true,
                radiusSize: 25.0,
                fontSize: 16.0,
              ),
            ),
          ),
          /* SizedBox.fromSize(
            size: Size.square(widthDevice / 3.6),
            child: Card(
              color: Colors.grey.shade300,
              child: LabelBelowIcon(
                betweenHeight: 15.0,
                icon: thirdIcon,
                label: thirdLabel,
                iconColor: Colors.indigo.shade800,
                isCircleEnabled: false,
              ),
            ),
          ), */
        ],
      ),
    );
  }
}
