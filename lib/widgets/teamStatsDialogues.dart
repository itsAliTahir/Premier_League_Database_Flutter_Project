import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/dataprovider.dart';
import '../screens/teamScreen.dart';
import 'calculateData.dart';

class MyTeamStatsDialogue extends StatefulWidget {
  late IconData myIcon;
  late String myTitle;
  late String mySubTitle;
  late String myProcedure;
  MyTeamStatsDialogue(
      {required this.myIcon,
      required this.myTitle,
      required this.mySubTitle,
      required this.myProcedure});

  @override
  State<MyTeamStatsDialogue> createState() => _MyTeamStatsDialogueState();
}

class _MyTeamStatsDialogueState extends State<MyTeamStatsDialogue> {
  @override
  Widget build(BuildContext context) {
    List<PointsTable> myPointsTable =
        Provider.of<DataProvider>(context, listen: false).getPointsTable;
    late int showResult;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 285,
      child: Card(
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
                height: 60,
                margin: EdgeInsets.all(2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              widget.myIcon,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${widget.myTitle}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // color: Colors.red,
                              width: 3.5,
                              height: 30,
                              child: Text(
                                " ",
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                            Container(
                              // color: Colors.blue,
                              width: 190,
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
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        width: 40,
                        height: 22,
                        child: Text(
                          " Played ",
                          style: TextStyle(fontSize: 11),
                        )),
                    Container(
                        width: 40,
                        height: 22,
                        child: Text(
                          " ${widget.mySubTitle} ",
                          style: TextStyle(fontSize: 11),
                        )),
                  ],
                )),
            Divider(),
            Container(
              height: 175,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  if (widget.myProcedure == "Scored") {
                    myPointsTable.sort((b, a) => a.GF.compareTo(b.GF));
                    showResult = myPointsTable[index].GF;
                  } else if (widget.myProcedure == "Conceded") {
                    myPointsTable.sort((b, a) => a.GA.compareTo(b.GA));
                    showResult = myPointsTable[index].GA;
                  } else if (widget.myProcedure == "CleanSheets") {
                    myPointsTable
                        .sort((b, a) => a.cleanSheets.compareTo(b.cleanSheets));
                    showResult = myPointsTable[index].cleanSheets;
                  } else
                    null;

                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      margin: EdgeInsets.all(2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // color: Colors.red,
                                width: 3.5,
                                height: 30,
                                child: Text(
                                  " ",
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                              Container(
                                width: 190,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      " ${index + 1} ",
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 22,
                                      height: 22,
                                      child: Image.asset(
                                        '${myPointsTable[index].teamLogo}',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    FittedBox(
                                        child: Text(
                                      "${myPointsTable[index].teamName}",
                                      style: TextStyle(fontSize: 14),
                                    ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          Container(
                              width: 40,
                              child: Center(
                                child: Text(
                                  "${myPointsTable[index].played}",
                                  style: TextStyle(fontSize: 13.5),
                                ),
                              )),
                          Container(
                              width: 40,
                              child: Center(
                                child: Text(
                                  "$showResult",
                                  style: TextStyle(fontSize: 13.5),
                                ),
                              )),
                        ],
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
