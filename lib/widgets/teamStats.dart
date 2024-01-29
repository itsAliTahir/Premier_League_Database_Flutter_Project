import 'package:flutter/material.dart';
import 'teamStatsDialogues.dart';

class MyTeamStats extends StatelessWidget {
  const MyTeamStats({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            MyTeamStatsDialogue(
                myIcon: Icons.flag,
                myTitle: "Most Goals Scored",
                mySubTitle: "Goals",
                myProcedure: "Scored"),
            MyTeamStatsDialogue(
                myIcon: Icons.crisis_alert_rounded,
                myTitle: "Most Goals Conceded",
                mySubTitle: "Goals",
                myProcedure: "Conceded"),
            MyTeamStatsDialogue(
                myIcon: Icons.shield,
                myTitle: "Most Clean Sheets",
                mySubTitle: "   CS",
                myProcedure: "CleanSheets"),
          ],
        ),
      ),
    );
  }
}
