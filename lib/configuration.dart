import 'package:flutter/material.dart';

Color primaryGreen = const Color(0xff416d6d);
List<BoxShadow> shadowList = [
   const BoxShadow(color: Colors.grey, blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {'name': 'Plantas', 'iconPath': 'images/icon_plant.png'},
  {'name': 'Flores', 'iconPath': 'images/icon_flor.png'},
  {'name': 'Frutíferas', 'iconPath': 'images/icon_frut.png'},
  {'name': 'Horta', 'iconPath': 'images/icon_horta.png'},
  {'name': 'Bonsai', 'iconPath': 'images/icon_bonsai.png'}
];
List<Map> detailsPlant = [
  {'name': '1 Metro', 'iconPath': 'images/icon_tamanho.png'},
  {'name': 'Brilhosa', 'iconPath': 'images/icon_sol.png'},
  {'name': 'Rega', 'iconPath': 'images/icon_rega.png'},

];
List<Map> detailsBonSai = [
  {'name': 'Flores', 'iconPath': 'images/icon_flor_bonsai.png'},
  {'name': 'Adubo', 'iconPath': 'images/icon_fert.png'},
  {'name': 'Poda', 'iconPath': 'images/icon_poda.png'},

];