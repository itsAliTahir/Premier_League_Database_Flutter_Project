import 'package:flutter/material.dart';

class PointsTable {
  late int teamId;
  late String teamName;
  late String teamLogo;
  late Color teamColor;
  late String abbreviation;
  late int played;
  late int wins;
  late int loses;
  late int draws;
  late int points;
  late int GF;
  late int GA;
  late int GD;
  late int cleanSheets;
  PointsTable(
      {required this.teamId,
      required this.teamName,
      required this.teamLogo,
      required this.teamColor,
      required this.abbreviation,
      required this.played,
      required this.wins,
      required this.loses,
      required this.draws,
      required this.points,
      required this.GF,
      required this.GA,
      required this.GD,
      required this.cleanSheets});
}
