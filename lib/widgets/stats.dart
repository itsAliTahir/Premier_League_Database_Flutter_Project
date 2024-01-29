import 'package:flutter/material.dart';
import 'teamFormStats.dart';
import 'teamDetailsStats.dart';
import 'teamFormationStats.dart';

class MyStats extends StatelessWidget {
  int teamId;
  int rank;
  MyStats(this.teamId, this.rank);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            MyTeamFormation(teamId, rank),
            MyTeamForm(teamId),
            MyTeamDetail(teamId, rank)
          ],
        ),
      ),
    );
  }
}
