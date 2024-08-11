
import 'package:barcode_app/resources/dimens.dart';
import 'package:flutter/material.dart';

const bsBorderRadius = BorderRadius.only(topLeft: Radius.circular(DDimens.bs), topRight: Radius.circular(DDimens.bs));
const bsBorder = RoundedRectangleBorder(borderRadius: bsBorderRadius);

const popupBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(DDimens.xl)),
  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
);
