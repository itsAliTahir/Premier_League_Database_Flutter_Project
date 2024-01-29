import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/dataprovider.dart';
import '../models/matchesModal.dart';
import '../models/teamsModal.dart';
import 'calculateData.dart';
import '../screens/teamScreen.dart';

class MyPointsTable extends StatefulWidget {
  const MyPointsTable({super.key});

  @override
  State<MyPointsTable> createState() => _MyPointsTableState();
}

class _MyPointsTableState extends State<MyPointsTable> {
  List<TeamsData> providedTeasms = [];

  List<MatchData> providedMatchData = [];
  List<PointsTable> myPointsTable = [];
  @override
  void initState() {
    providedTeasms =
        Provider.of<DataProvider>(context, listen: false).getTeamdata;
    providedMatchData =
        Provider.of<DataProvider>(context, listen: false).getmatchData;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myPointsTable = Provider.of<DataProvider>(context).getPointsTable;
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
              // color: Colors.red,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 3.5,
                        height: 30,
                        child: Text(
                          " ",
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      Container(
                        width: 170,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              " # ",
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              " ",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 215,
                    // color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PL",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          " W",
                          style: TextStyle(fontSize: 11),
                        ), // won
                        Text(
                          "  L",
                          style: TextStyle(fontSize: 11),
                        ), // lost
                        Text(
                          "    D",
                          style: TextStyle(fontSize: 11),
                        ), // draw
                        Text(
                          "  GF",
                          style: TextStyle(fontSize: 11),
                        ), // GF
                        Text(
                          " GA",
                          style: TextStyle(fontSize: 11),
                        ), // GC
                        Text(
                          " GD",
                          style: TextStyle(fontSize: 11),
                        ), // GD
                        Text(
                          "Pts",
                          style: TextStyle(fontSize: 11),
                        ), // Points
                      ],
                    ),
                  ), // played
                ],
              )),
          Divider(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 270,
            // color: Colors.red,
            child: ListView.builder(
              itemCount: providedTeasms.length + 1,
              itemBuilder: (context, index) {
                print(index);
                myPointsTable.sort((b, a) => a.GF.compareTo(b.GF));
                myPointsTable.sort((b, a) => a.GD.compareTo(b.GD));
                myPointsTable.sort((b, a) => a.points.compareTo(b.points));
                if (index < providedTeasms.length)
                  return Ink(
                    child: InkWell(
                      splashFactory: InkSparkle.splashFactory,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DefaultTabController(
                                length: 2, // Number of tabs
                                child: MyTeamScreen(
                                    myPointsTable[index].teamId, index),
                              ),
                            )).then((result) {
                          setState(() {});
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        // color: Colors.blue,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 3.5,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: index + 1 <= 4
                                          ? Colors.blue
                                          : index + 1 == 5 || index + 1 == 6
                                              ? Colors.orange
                                              : index + 1 == 7
                                                  ? Colors.green
                                                  : index + 1 >= 18
                                                      ? Colors.red
                                                      : Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  child: Text(" "),
                                ),
                                Container(
                                  width: 170,
                                  // color: Colors.blueGrey,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      index < 9
                                          ? Text(" ${index + 1} ")
                                          : Text("${index + 1}"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 22,
                                        height: 22,
                                        child: Hero(
                                          tag:
                                              "${myPointsTable[index].teamId - 1}",
                                          child: Image.asset(
                                              //hisdjoskdkosdkapdlapdladpadad
                                              "assets/logos/${myPointsTable[index].teamId - 1}.png"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${myPointsTable[index].teamName}",
                                        style: TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 215,
                              // color: Colors.amber,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                      child: Text(
                                    "${myPointsTable[index].played}",
                                    style: TextStyle(fontSize: 14),
                                  )), // played

                                  FittedBox(
                                      child: Text(
                                    "${myPointsTable[index].wins}",
                                    style: TextStyle(fontSize: 14),
                                  )), // won

                                  FittedBox(
                                      child: Text(
                                    "${myPointsTable[index].loses}",
                                    style: TextStyle(fontSize: 14),
                                  )), // lost
                                  FittedBox(
                                      child: Text(
                                    "${myPointsTable[index].draws}",
                                    style: TextStyle(fontSize: 14),
                                  )), // draw

                                  FittedBox(
                                      child: Text(
                                    "${myPointsTable[index].GF}",
                                    style: TextStyle(fontSize: 14),
                                  )), // GF

                                  FittedBox(
                                      child: Text(
                                    "${myPointsTable[index].GA}",
                                    style: TextStyle(fontSize: 14),
                                  )), // GA

                                  FittedBox(
                                      child: Text(
                                    "${myPointsTable[index].GD}",
                                    style: TextStyle(fontSize: 14),
                                  )), // GD

                                  FittedBox(
                                      child: Text(
                                    "${myPointsTable[index].points}",
                                    style: TextStyle(fontSize: 14),
                                  )), // Points
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                else
                  return Container(
                    width: double.infinity,
                    height: 90,
                    // color: Colors.amber,
                    child: Column(
                      children: [
                        Divider(),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.circle,
                              size: 12,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "UEFA Champions League",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.circle,
                              size: 12,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "UEFA Europa League",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.circle,
                              size: 12,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "UEFA Conference League",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.circle,
                              size: 12,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Relegation",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
