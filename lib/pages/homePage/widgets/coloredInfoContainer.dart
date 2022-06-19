import 'package:flutter/material.dart';
import 'package:sampleflutter/helpers/sizeHelper.dart';

class ColoredInfoContainer extends StatelessWidget {
  final Color mainColor;
  final String title;
  const ColoredInfoContainer({Key? key, required this.mainColor, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: sizeHelper.height! * 0.025,
          width: sizeHelper.height! * 0.025,
          color: mainColor,
        ),
        Text(
          title,
          style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
