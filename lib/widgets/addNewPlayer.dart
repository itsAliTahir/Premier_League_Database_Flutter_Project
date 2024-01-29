import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/dataprovider.dart';
import 'package:dbsproject/models/teamsModal.dart';

import '../models/squadmodal.dart';

// ignore: must_be_immutable
class MyAddNewPlayer extends StatefulWidget {
  final int teamId;
  const MyAddNewPlayer(this.teamId, {super.key});

  @override
  State<MyAddNewPlayer> createState() => _MyAddNewPlayerState();
}

class _MyAddNewPlayerState extends State<MyAddNewPlayer> {
  //final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();
  // String _inputText = '';

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String newPlayerName = "";
  List<String> positions = ["GK", "DEF", "MID", "ATK"];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    List<Squad> squadList = Provider.of<DataProvider>(context).getSquadData;
    return Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
            height: 230,
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
                        Text("Add New Player"),
                        Divider(),
                        TextFormField(
                          style: const TextStyle(
                              color: Color.fromARGB(255, 4, 4, 4)),
                          decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter Player Name",
                            label: const Text(
                              "Player Name",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(20, 21, 25, 1)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                          ),
                          onChanged: (value) {
                            newPlayerName = value;
                            if (newPlayerName.length == 0) newPlayerName = "";
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Player Role:  ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                index++;
                                if (index == 4) index = 0;
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Text(positions[index]),
                              ),
                            )
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 44,
                          height: 64,
                          child: IconButton(
                            iconSize: 30,
                            // color: Color.fromARGB(255, 93, 93, 93),
                            color: Colors.redAccent,
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                      SizedBox(
                          width: 54,
                          height: 64,
                          child: IconButton(
                            iconSize: 30,
                            color: newPlayerName.length > 0
                                ? Colors.greenAccent
                                : Color.fromARGB(255, 139, 139, 139),
                            icon: Icon(Icons.check),
                            onPressed: () async {
                              if (newPlayerName.length == 0) return;
                              await Provider.of<DataProvider>(context,
                                      listen: false)
                                  .addPlayer(
                                      Squad(
                                        widget.teamId,
                                        squadList.length,
                                        newPlayerName,
                                        positions[index],
                                      ),
                                      'players');

                              Navigator.pop(context);
                            },
                          )),
                    ],
                  ),
                ),
              ],
            )));
  }
}
