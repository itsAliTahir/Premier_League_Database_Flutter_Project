import 'package:dbsproject/widgets/matchTeamsFormation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/dataprovider.dart';
import '../models/matchesModal.dart';
import '../models/stadiummodal.dart';
import '../models/teamsModal.dart';
import '../widgets/matchTeamsSquad.dart';

class MyMatchResult extends StatefulWidget {
  final int matchId;
  const MyMatchResult(this.matchId, {super.key});

  @override
  State<MyMatchResult> createState() => _MyMatchResultState();
}

class _MyMatchResultState extends State<MyMatchResult> {
  @override
  Widget build(BuildContext context) {
    List<MatchData> providedMatchData =
        Provider.of<DataProvider>(context).getmatchData;

    List<Stadiums> providedStadiumData =
        Provider.of<DataProvider>(context).getStadiumData;

    List<TeamsData> providedTeamData =
        Provider.of<DataProvider>(context).getTeamdata;
    var homeTeamId = providedMatchData[widget.matchId].homeTeamId - 1;
    var awayTeamId = providedMatchData[widget.matchId].awayTeamId - 1;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        iconTheme: IconThemeData(color: Colors.black),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        )),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(95.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 100,
                height: 100,
                // color: Colors.red,
                child: Column(children: [
                  Container(
                    width: 60,
                    height: 60,
                    // color: Colors.blue,
                    child: Image.asset(
                      'assets/logos/${providedMatchData[widget.matchId].homeTeamId - 1}.png',
                    ),
                  ),
                  SizedBox(height: 10),
                  FittedBox(
                      child:
                          Text("${providedTeamData[homeTeamId + 1].teamName}")),
                ]),
              ),
              Container(
                width: 100,
                height: 100,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Text(
                        "${providedStadiumData[providedMatchData[widget.matchId].matchStadiumId].stadiumName}",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        "${providedMatchData[widget.matchId].homeTeamGoals}  -  ${providedMatchData[widget.matchId].awayTeamGoals}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 100,
                // color: Colors.red,
                child: Column(children: [
                  Container(
                    width: 60,
                    height: 60,
                    // color: Colors.blue,
                    child: Image.asset(
                      'assets/logos/${providedMatchData[widget.matchId].awayTeamId - 1}.png',
                    ),
                  ),
                  SizedBox(height: 10),
                  FittedBox(
                      child:
                          Text("${providedTeamData[awayTeamId + 1].teamName}")),
                ]),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyMatchTeamFormation(
              homeTeamId + 1,
              awayTeamId + 1,
            ),
            MyMatchTeamSquad(
              homeTeamId + 1,
              awayTeamId + 1,
            ),
          ],
        ),
      ),
    );
  }
}
