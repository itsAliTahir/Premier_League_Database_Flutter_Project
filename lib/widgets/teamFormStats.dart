import 'package:dbsproject/models/teamsModal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/dataprovider.dart';
import '../models/matchesModal.dart';

class TeamForm {
  late int opponentTeamID;
  late int goals1;
  late int goals2;
  late String result;
  TeamForm(this.opponentTeamID, this.goals1, this.goals2, this.result);
}

// ignore: must_be_immutable
class MyTeamForm extends StatefulWidget {
  int teamId;
  MyTeamForm(this.teamId, {super.key});

  @override
  State<MyTeamForm> createState() => _MyTeamFormState();
}

class _MyTeamFormState extends State<MyTeamForm> {
  List<TeamForm> teamFormList = [];

  void TeamFormCal(List<MatchData> providedMatchData) {
    teamFormList = [];
    for (int j = providedMatchData.length - 1; j >= 0; j--) {
      late int OTID = widget.teamId;
      late int g1 = 0;
      late int g2 = 0;
      late String res = "nil";

      if (providedMatchData[j].completed == 1) {
        if (widget.teamId == providedMatchData[j].homeTeamId) {
          OTID = providedMatchData[j].awayTeamId;
          g1 = providedMatchData[j].homeTeamGoals;
          g2 = providedMatchData[j].awayTeamGoals;
          if (g1 > g2)
            res = "win";
          else if (g1 < g2)
            res = "lose";
          else
            res = "draw";
        } else if (widget.teamId == providedMatchData[j].awayTeamId) {
          OTID = providedMatchData[j].homeTeamId;
          g1 = providedMatchData[j].homeTeamGoals;
          g2 = providedMatchData[j].awayTeamGoals;
          if (g1 > g2)
            res = "lose";
          else if (g1 < g2)
            res = "win";
          else
            res = "draw";
        }
      }
      if (res != "nil") {
        final match = TeamForm(OTID, g1, g2, res);
        teamFormList.add(match);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<MatchData> providedMatchData =
        Provider.of<DataProvider>(context).getmatchData;
    List<TeamsData> providedTeamData =
        Provider.of<DataProvider>(context).getTeamdata;
    TeamFormCal(providedMatchData);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Color.fromARGB(207, 255, 255, 255),
      elevation: 10,
      shadowColor: Colors.black,
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              margin: EdgeInsets.all(2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.line_axis,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Team Form",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          Divider(),
          Container(
            height: 120,
            child: teamFormList.length == 0
                ? Center(child: Text("No Match Played"))
                : Row(
                    mainAxisAlignment: teamFormList.length >= 5
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < teamFormList.length && i < 5; i++)
                        Container(
                          width: teamFormList.length >= 5 ? 60 : 70,
                          height: 110,
                          // color: Colors.amber,
                          child: Card(
                            margin: teamFormList.length >= 5
                                ? EdgeInsets.all(0)
                                : EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Container(
                                  height: 5,
                                  decoration: BoxDecoration(
                                      color: providedTeamData[widget.teamId]
                                          .teamColor,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                        "assets/logos/${teamFormList[i].opponentTeamID - 1}.png")),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  providedTeamData[
                                          teamFormList[i].opponentTeamID]
                                      .abbreviation,
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  width: 45,
                                  height: 20,
                                  child: Center(
                                      child: Text(
                                          "${teamFormList[i].goals1}-${teamFormList[i].goals2}")),
                                  decoration: BoxDecoration(
                                    color: teamFormList[i].result == "win"
                                        ? Colors.green
                                        : teamFormList[i].result == "lose"
                                            ? Colors.red
                                            : Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
