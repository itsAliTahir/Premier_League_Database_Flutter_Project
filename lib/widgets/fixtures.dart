import 'package:dbsproject/models/stadiummodal.dart';
import 'package:dbsproject/models/teamsModal.dart';
import 'package:dbsproject/screens/matchResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addNewMatch.dart';
import '../Provider/dataprovider.dart';
import '../models/matchesModal.dart';

class MyFixtures extends StatefulWidget {
  MyFixtures({super.key});

  @override
  State<MyFixtures> createState() => _MyFixturesState();
}

class _MyFixturesState extends State<MyFixtures> {
  @override
  Widget build(BuildContext context) {
    List<MatchData> providedMatchData =
        Provider.of<DataProvider>(context).getmatchData;

    List<Stadiums> providedStadiumData =
        Provider.of<DataProvider>(context).getStadiumData;

    List<TeamsData> providedTeamData =
        Provider.of<DataProvider>(context).getTeamdata;

    providedMatchData.sort((b, a) => a.completed.compareTo(b.completed));

    void _addNewMatchDialogue(BuildContext ctx, int i) {
      showDialog(
          context: ctx,
          builder: (_) {
            if (i < providedMatchData.length) {
              return MyAddNewMatch(providedMatchData[i].matchId);
            } else
              return MyAddNewMatch(i);
          });
    }

    Color lightenColor(Color color, double amount) {
      final hslColor = HSLColor.fromColor(color);
      final lightness = hslColor.lightness + amount;

      // Ensure lightness is within the valid range of 0.0 to 1.0
      final newLightness = lightness.clamp(0.0, 1.0);

      return hslColor.withLightness(newLightness).toColor();
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 20),
        itemCount: providedMatchData.length + 1,
        itemBuilder: (context, index) {
          //final index = index2 + 1;
          if (index < providedMatchData.length)
            return GestureDetector(
              onTap: () {
                if (providedMatchData[index].completed == 0)
                  _addNewMatchDialogue(context, index);
                else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyMatchResult(providedMatchData[index].matchId)),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.all(1),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Card(
                  elevation: 3,
                  color: const Color.fromARGB(207, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(children: [
                    Positioned(
                        left: 20,
                        bottom: 5,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          width: 80,
                          height: 80,
                          child: Image.asset(
                            "assets/logos/${providedMatchData[index].homeTeamId - 1}.png",
                          ),
                        )),
                    Positioned(
                        right: 20,
                        bottom: 5,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          width: 80,
                          height: 80,
                          child: Image.asset(
                            "assets/logos/${providedMatchData[index].awayTeamId - 1}.png",
                          ),
                        )),
                    Positioned(
                      left: 100,
                      bottom: -10,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: 80,
                        height: 80,
                        child: Text(providedTeamData[
                                providedMatchData[index].homeTeamId]
                            .abbreviation),
                      ),
                    ),
                    Positioned(
                      right: 75,
                      bottom: -10,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: 80,
                        height: 80,
                        child: Text(providedTeamData[
                                providedMatchData[index].awayTeamId]
                            .abbreviation),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: (MediaQuery.of(context).size.width - 110) / 2,
                      child: Center(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(10))),
                          width: 100,
                          height: 20,
                          child: Center(
                            child: Text(
                              providedStadiumData[
                                      providedMatchData[index].matchStadiumId]
                                  .stadiumName,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                        child: providedMatchData[index].completed == 1
                            ? Text(
                                "${providedMatchData[index].homeTeamGoals}   -   ${providedMatchData[index].awayTeamGoals}")
                            : const Icon(
                                Icons.alarm,
                                size: 15,
                              ))
                  ]),
                ),
              ),
            );
          else
            return Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Ink(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 105, 25, 119),
                      borderRadius: BorderRadius.circular(45)),
                  child: InkWell(
                    splashColor: Color.fromARGB(255, 97, 21, 110),
                    borderRadius: BorderRadius.circular(45),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onTap: () {
                      _addNewMatchDialogue(context, index);
                    },
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}
