import 'package:dbsproject/widgets/calculateData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/dataprovider.dart';
import '../models/teamsModal.dart';

class MyMatchTeamFormation extends StatefulWidget {
  int teamId1;
  int teamId2;
  MyMatchTeamFormation(this.teamId1, this.teamId2);

  @override
  State<MyMatchTeamFormation> createState() => _MyMatchTeamFormationState();
}

class _MyMatchTeamFormationState extends State<MyMatchTeamFormation> {
  @override
  Widget build(BuildContext context) {
    List<TeamsData> providedTeasms =
        Provider.of<DataProvider>(context).getTeamdata;
    String numbersString1 = providedTeasms[widget.teamId1].formation;
    List<int> numbersList1 =
        numbersString1.split('-').map((number) => int.parse(number)).toList();
    String numbersString2 = providedTeasms[widget.teamId2].formation;
    List<int> numbersList2 =
        numbersString2.split('-').map((number) => int.parse(number)).toList();
    for (int i = numbersList2.length - 1; i >= 0; i--) {
      numbersList1.add(numbersList2[i]);
    }
    numbersList1.insert(0, 1);
    numbersList1.add(1);
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
              child: const Row(
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
                            Icons.linear_scale,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Formation",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
          const Divider(),
          Text(
              "(${providedTeasms[widget.teamId1].formation})                      (${providedTeasms[widget.teamId2].formation}) "),
          const SizedBox(
            height: 7,
          ),
          Container(
              width: 300,
              height: 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                // border: Border.all(),
                image: const DecorationImage(
                  image: AssetImage('assets/field.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                // margin: const EdgeInsets.only(right: ),
                // color: Colors.amber,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 8; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int j = 0; j < numbersList1[i]; j++)
                            Container(
                              width: 17,
                              height: 17,
                              decoration: BoxDecoration(
                                  color: i <= 3
                                      ? providedTeasms[widget.teamId1].teamColor
                                      : providedTeasms[widget.teamId2]
                                          .teamColor,
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                        ],
                      )
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
