import 'package:flutter/material.dart';

final baseTextStyle = TextStyle(fontFamily: 'Roboto');

final headerTextStyle = baseTextStyle.copyWith(
    color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

final regularTextStyle = baseTextStyle.copyWith(
    color: Colors.white, fontSize: 9.0, fontWeight: FontWeight.w400);

final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
final priceTextStyle =
    regularTextStyle.copyWith(color: Colors.red, fontSize: 12.0);
