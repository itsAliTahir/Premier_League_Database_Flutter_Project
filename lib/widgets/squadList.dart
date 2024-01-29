import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/dataprovider.dart';
import '../models/squadmodal.dart';
import 'addNewPlayer.dart';

class MySquadList extends StatefulWidget {
  int teamId;
  MySquadList(this.teamId, {super.key});

  @override
  State<MySquadList> createState() => _MySquadListState();
}

class _MySquadListState extends State<MySquadList> {
  int deleteIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<Squad> providedSquadData =
        Provider.of<DataProvider>(context).getSquadData;

    List<Squad> squad = [];
    void makeSquadList() {
      for (int i = 0; i < providedSquadData.length; i++) {
        if (widget.teamId == providedSquadData[i].teamId) {
          final player = Squad(
              providedSquadData[i].teamId,
              providedSquadData[i].playerId,
              providedSquadData[i].playerName,
              providedSquadData[i].playerPosition);
          squad.add(player);
        }
      }
    }

    void _addNewPlayerDialogue(BuildContext ctx) {
      showDialog(
          context: ctx,
          builder: (_) {
            return MyAddNewPlayer(widget.teamId);
          });
    }

    Future<void> _deletePlayer(int index) async {
      // delete this index player
      print(index);

      await Provider.of<DataProvider>(context, listen: false)
          .deletePlayer(squad[index].playerId, 'players');

      //
      deleteIndex = -1;
      setState(() {});
    }

    makeSquadList();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Card(
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
                  height: 70,
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
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.person,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Squad",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  child: const Icon(Icons.add, size: 25),
                                  onTap: () {
                                    _addNewPlayerDialogue(context);
                                  },
                                )
                              ],
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                // color: Colors.red,
                                width: 3.5,
                                height: 30,
                                child: Text(
                                  " ",
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                              SizedBox(
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
                    ],
                  )),
              const Divider(),
              SizedBox(
                height: (34.0 * squad.length) + 13,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: squad.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        deleteIndex = index;
                        print(deleteIndex);
                        setState(() {});
                      },
                      onTap: () {
                        deleteIndex = -1;
                        setState(() {});
                      },
                      child: Container(
                          decoration: deleteIndex == index
                              ? BoxDecoration(border: Border.all())
                              : BoxDecoration(),
                          width: MediaQuery.of(context).size.width,
                          height: deleteIndex == index ? 42 : 30,
                          margin: const EdgeInsets.all(2),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    // color: Colors.red,
                                    width: 3.5,
                                    height: 30,
                                    child: Text(
                                      " ",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 190,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "$index",
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        FittedBox(
                                            child: Text(
                                          squad[index].playerName,
                                          style: const TextStyle(fontSize: 14),
                                        ))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              Container(
                                  width: 40,
                                  // color: Colors.red,
                                  child: Center(
                                    child: Text(
                                      squad[index].playerPosition,
                                      style: const TextStyle(fontSize: 13.5),
                                    ),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              deleteIndex == index
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        _deletePlayer(index);
                                      },
                                      color: Colors.red,
                                    )
                                  : const SizedBox(),
                            ],
                          )),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
