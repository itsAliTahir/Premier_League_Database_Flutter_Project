import 'package:flutter/material.dart';
import 'package:dbsproject/models/stadiummodal.dart';
import 'package:dbsproject/models/teamsModal.dart';
import 'package:provider/provider.dart';
import '../Provider/dataprovider.dart';
import '../models/matchesModal.dart';

// ignore: must_be_immutable
class MyAddNewMatch extends StatefulWidget {
  int matchId;
  MyAddNewMatch(this.matchId);

  @override
  State<MyAddNewMatch> createState() => _MyAddNewMatchState();
}

class _MyAddNewMatchState extends State<MyAddNewMatch> {
  int homeTeamId = 0;
  int awayTeamID = -1;
  int homeTeamGoals = 0;
  int awayTeamGoals = 0;
  int matchStadium = 0;
  bool isDone = false;
  bool sameAsHomeTeam = false;
  bool editable = true;

  @override
  Widget build(BuildContext context) {
    List<MatchData> providedMatchData =
        Provider.of<DataProvider>(context).getmatchData;

    List<Stadiums> providedStadiumData =
        Provider.of<DataProvider>(context).getStadiumData;

    List<TeamsData> providedTeamData =
        Provider.of<DataProvider>(context).getTeamdata;

    if (editable == true) {
      editable = false;
      if (widget.matchId < providedMatchData.length) {
        homeTeamId = providedMatchData[widget.matchId].homeTeamId - 1;
        awayTeamID = providedMatchData[widget.matchId].awayTeamId - 1;
        matchStadium = providedMatchData[widget.matchId].matchStadiumId - 1;
        setState(() {});
      }
    }

    return Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
            height: 455,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 236, 236, 236),
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      child: Column(children: [
                        Text("Match Data"),
                        Divider(),
                        Container(
                            height: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 250,
                                  width: 100,
                                  // color: Colors.red,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Home",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: Image.asset(
                                          'assets/logos/$homeTeamId.png',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(providedTeamData[homeTeamId + 1]
                                          .abbreviation),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                homeTeamId--;
                                                if (homeTeamId == awayTeamID)
                                                  homeTeamId--;
                                                if (homeTeamId < -1)
                                                  homeTeamId = 18;
                                                if (homeTeamId == awayTeamID)
                                                  homeTeamId--;
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                  Icons.keyboard_arrow_left)),
                                          IconButton(
                                              onPressed: () {
                                                homeTeamId++;
                                                if (homeTeamId == awayTeamID)
                                                  homeTeamId++;
                                                if (homeTeamId > 18)
                                                  homeTeamId = -1;
                                                if (homeTeamId == awayTeamID)
                                                  homeTeamId++;
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                  Icons.keyboard_arrow_right)),
                                        ],
                                      ),
                                      Divider(),
                                      Text(
                                        'Goals',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        child: Center(
                                          child: Text("$homeTeamGoals"),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                if (homeTeamGoals == 0)
                                                  return;
                                                else
                                                  homeTeamGoals--;
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.remove)),
                                          IconButton(
                                              onPressed: () {
                                                homeTeamGoals++;

                                                setState(() {});
                                              },
                                              icon: Icon(Icons.add)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 250,
                                  width: 100,
                                  // color: Colors.red,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Away",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: Image.asset(
                                          'assets/logos/$awayTeamID.png',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(providedTeamData[awayTeamID + 1]
                                          .abbreviation),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                awayTeamID--;
                                                if (homeTeamId == awayTeamID)
                                                  awayTeamID--;
                                                if (awayTeamID < -1)
                                                  awayTeamID = 18;
                                                if (homeTeamId == awayTeamID)
                                                  awayTeamID--;
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                  Icons.keyboard_arrow_left)),
                                          IconButton(
                                              onPressed: () {
                                                awayTeamID++;
                                                if (homeTeamId == awayTeamID)
                                                  awayTeamID++;
                                                if (awayTeamID > 18)
                                                  awayTeamID = -1;
                                                if (homeTeamId == awayTeamID)
                                                  awayTeamID++;
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                  Icons.keyboard_arrow_right)),
                                        ],
                                      ),
                                      Divider(),
                                      Text(
                                        'Goals',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        child: Center(
                                          child: Text("$awayTeamGoals"),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                if (awayTeamGoals == 0)
                                                  return;
                                                else
                                                  awayTeamGoals--;
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.remove)),
                                          IconButton(
                                              onPressed: () {
                                                awayTeamGoals++;
                                                setState(() {});
                                              },
                                              icon: Icon(Icons.add)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text("Stadium"),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     sameAsHomeTeam == false
                            //         ? IconButton(
                            //             onPressed: () {
                            //               matchStadium--;
                            //               if (matchStadium == -2)
                            //                 matchStadium = 18;
                            //               setState(() {});
                            //             },
                            //             icon: Icon(Icons.keyboard_arrow_left),
                            //           )
                            //         : IconButton(
                            //             onPressed: null,
                            //             icon: Icon(
                            //               Icons.keyboard_arrow_left,
                            //             ),
                            //           ),
                            //     Container(
                            //       width: 150,
                            //       height: 25,
                            //       decoration:
                            //           BoxDecoration(border: Border.all()),
                            //       child: Center(
                            //           child: Text(
                            //         providedStadiumData[matchStadium + 1]
                            //             .stadiumName,
                            //       )),
                            //     ),
                            //     sameAsHomeTeam == false
                            //         ? IconButton(
                            //             onPressed: () {
                            //               matchStadium++;
                            //               if (matchStadium == 19)
                            //                 matchStadium = -1;
                            //               setState(() {});
                            //             },
                            //             icon: Icon(Icons.keyboard_arrow_right),
                            //           )
                            //         : IconButton(
                            //             onPressed: null,
                            //             icon: Icon(Icons.keyboard_arrow_right),
                            //           ),
                            //   ],
                            // )
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Text("Home Team Stadium:"),
                        //     Switch(
                        //       activeColor: Color.fromARGB(255, 90, 22, 102),
                        //       value: sameAsHomeTeam,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           sameAsHomeTeam = value;
                        //           if (sameAsHomeTeam == true)
                        //             matchStadium = homeTeamId;
                        //         });
                        //       },
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Match Completed:      "),
                            Switch(
                              activeColor: Color.fromARGB(255, 90, 22, 102),
                              value: isDone,
                              onChanged: (value) {
                                setState(() {
                                  isDone = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 44,
                                height: 64,
                                child: IconButton(
                                  iconSize: 30,
                                  color: Colors.redAccent,
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                            SizedBox(
                              width: 40,
                            ),
                            SizedBox(
                                width: 54,
                                height: 64,
                                child: IconButton(
                                  iconSize: 30,
                                  color: Colors.greenAccent,
                                  icon: Icon(Icons.check),
                                  onPressed: () {
                                    if (widget.matchId >=
                                        providedMatchData.length) {
                                      // add new match code
                                      Provider.of<DataProvider>(context,
                                              listen: false)
                                          .addFixture(MatchData(
                                        matchId: widget.matchId,
                                        homeTeamId: homeTeamId + 1,
                                        awayTeamId: awayTeamID + 1,
                                        homeTeamGoals: homeTeamGoals,
                                        awayTeamGoals: awayTeamGoals,
                                        matchStadiumId: homeTeamId + 1,
                                        completed: isDone ? 1 : 0,
                                      ));
                                    }
                                    // update previous match Code
                                    else {
                                      Provider.of<DataProvider>(context,
                                              listen: false)
                                          .updateFixture(MatchData(
                                        matchId: widget.matchId,
                                        homeTeamId: homeTeamId + 1,
                                        awayTeamId: awayTeamID + 1,
                                        homeTeamGoals: homeTeamGoals,
                                        awayTeamGoals: awayTeamGoals,
                                        matchStadiumId: matchStadium + 1,
                                        completed: isDone ? 1 : 0,
                                      ));
                                      //
                                    }

                                    Navigator.pop(context);
                                  },
                                )),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            )));
    ;
  }
}
