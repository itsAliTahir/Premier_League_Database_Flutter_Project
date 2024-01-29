import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/dataprovider.dart';
import '../models/teamsModal.dart';
import '../models/squadmodal.dart';

class MyMatchTeamSquad extends StatefulWidget {
  int teamId1;
  int teamId2;
  MyMatchTeamSquad(this.teamId1, this.teamId2);

  @override
  State<MyMatchTeamSquad> createState() => _MyMatchTeamFormationState();
}

class _MyMatchTeamFormationState extends State<MyMatchTeamSquad> {
  @override
  Widget build(BuildContext context) {
    List<TeamsData> providedTeasms =
        Provider.of<DataProvider>(context).getTeamdata;
    List<Squad> providedSquadData =
        Provider.of<DataProvider>(context).getSquadData;
    List<TeamsData> providedTeamData =
        Provider.of<DataProvider>(context).getTeamdata;
    List<Squad> squad1 = [];
    List<Squad> squad2 = [];
    int MaxLength = 0;
    void makeSquadList() {
      for (int i = 0; i < providedSquadData.length; i++) {
        if (widget.teamId1 == providedSquadData[i].teamId) {
          final player = Squad(
              providedSquadData[i].teamId,
              providedSquadData[i].playerId,
              providedSquadData[i].playerName,
              providedSquadData[i].playerPosition);
          squad1.add(player);
        }
      }
      for (int i = 0; i < providedSquadData.length; i++) {
        if (widget.teamId2 == providedSquadData[i].teamId) {
          final player = Squad(
              providedSquadData[i].teamId,
              providedSquadData[i].playerId,
              providedSquadData[i].playerName,
              providedSquadData[i].playerPosition);
          squad2.add(player);
        }
      }
    }

    makeSquadList();
    if (squad1.length >= squad2.length) {
      MaxLength = squad1.length;
    } else {
      MaxLength = squad2.length;
    }

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
                            "Squad",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Positioned(
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: providedTeamData[widget.teamId1].teamColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    width: 5,
                    height: (34.0 * MaxLength) + 13,
                  )),
              Positioned(
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: providedTeamData[widget.teamId2].teamColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    width: 5,
                    height: (34.0 * MaxLength) + 13,
                  )),
              Center(
                child: SizedBox(
                    height: (34.0 * MaxLength) + 13,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: MaxLength,
                        itemBuilder: (context, index) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              margin: const EdgeInsets.all(2),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 160,
                                      // color: Colors.red,
                                      child: Center(
                                        child: FittedBox(
                                          child: index < squad1.length
                                              ? Text(
                                                  '${squad1[index].playerName} (${squad1[index].playerPosition})',
                                                  style: const TextStyle(
                                                      fontSize: 13.5),
                                                )
                                              : Text(
                                                  ' ',
                                                  style: const TextStyle(
                                                      fontSize: 13.5),
                                                ),
                                        ),
                                      )),
                                  Container(
                                      width: 160,
                                      // color: Colors.red,
                                      child: Center(
                                        child: FittedBox(
                                          child: index < squad2.length
                                              ? Text(
                                                  '${squad2[index].playerName} (${squad2[index].playerPosition}) ',
                                                  style: const TextStyle(
                                                      fontSize: 13.5),
                                                )
                                              : Text(
                                                  ' ',
                                                  style: const TextStyle(
                                                      fontSize: 13.5),
                                                ),
                                        ),
                                      )),
                                ],
                              ));
                        })),
              ),
            ],
          )
        ],
      ),
    );
  }
}
