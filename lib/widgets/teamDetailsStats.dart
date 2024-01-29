import 'package:dbsproject/widgets/calculateData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/dataprovider.dart';
import '../models/teamsModal.dart';

class MyTeamDetail extends StatefulWidget {
  int teamId;
  int rank;
  MyTeamDetail(this.teamId, this.rank, {super.key});

  @override
  State<MyTeamDetail> createState() => _MyTeamDetailState();
}

class _MyTeamDetailState extends State<MyTeamDetail> {
  @override
  Widget build(BuildContext context) {
    List<TeamsData> providedTeasms =
        Provider.of<DataProvider>(context).getTeamdata;
    List<PointsTable> myPointsTable =
        Provider.of<DataProvider>(context).getPointsTable;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: const Color.fromARGB(207, 255, 255, 255),
      elevation: 10,
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              margin: const EdgeInsets.all(2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.menu,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Team Stats",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          const Divider(),
          SizedBox(
              width: 300,
              height: 175,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 175,
                      decoration: BoxDecoration(
                          color: providedTeasms[widget.teamId].teamColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 175,
                          // color: Colors.amber,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Played: "),
                              Text("Won: "),
                              Text("Lost: "),
                              Text("Draw: "),
                              Text("Goals Scored: "),
                              Text("Goals Conceded: "),
                              Text("Clean Sheets: "),
                              Text("League Points: "),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        SizedBox(
                          width: 10,

                          height: 170,
                          // color: Colors.amber,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${myPointsTable[widget.rank].played}"),
                              Text("${myPointsTable[widget.rank].wins}"),
                              Text("${myPointsTable[widget.rank].loses}"),
                              Text("${myPointsTable[widget.rank].draws}"),
                              Text("${myPointsTable[widget.rank].GF}"),
                              Text("${myPointsTable[widget.rank].GA}"),
                              Text("${myPointsTable[widget.rank].cleanSheets}"),
                              Text("${myPointsTable[widget.rank].points}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
