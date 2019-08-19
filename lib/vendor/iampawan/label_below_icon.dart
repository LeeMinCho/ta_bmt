import 'package:flutter/material.dart';
import 'package:bmt_sahabat_umat/vendor/iampawan/uidata.dart';

class LabelBelowIcon extends StatelessWidget {
  final label;
  final IconData icon;
  final iconColor;
  final onPressed;
  final circleColor;
  final isCircleEnabled;
  final betweenHeight;
  final fontSize;
  final radiusSize;

  LabelBelowIcon(
      {this.label,
      this.icon,
      this.fontSize = 12.0,
      this.radiusSize = 20.0,
      this.onPressed,
      this.iconColor = Colors.white,
      this.circleColor,
      this.isCircleEnabled = true,
      this.betweenHeight = 5.0});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          isCircleEnabled
              ? CircleAvatar(
                  backgroundColor: circleColor,
                  radius: radiusSize,
                  child: Icon(
                    icon,
                    size: radiusSize - 3.0,
                    color: iconColor,
                  ),
                )
              : Icon(
                  icon,
                  size: 28.0,
                  color: iconColor,
                ),
          SizedBox(
            height: betweenHeight,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontFamily: UIData.ralewayFont, fontSize: fontSize),
          )
        ],
      ),
    );
  }
}
