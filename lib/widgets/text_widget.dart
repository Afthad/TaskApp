

import 'package:flutter/material.dart';

class TextWidget extends Text{
 final String text;
 final double fontSize;
  final FontWeight fontWeight;
  final Color color;
   const TextWidget({super.key,required this.text,required this.color,required this.fontSize,required this.fontWeight }) : super('');

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: fontSize,fontWeight: fontWeight),);
  }
}