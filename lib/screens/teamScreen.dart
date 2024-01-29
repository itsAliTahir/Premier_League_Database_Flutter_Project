import 'package:dbsproject/models/teamsModal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/dataprovider.dart';
import '../widgets/squadList.dart';
import '../widgets/stats.dart';

class MyTeamScreen extends StatelessWidget {
  final int selectedTeam;
  final int rank;
  const MyTeamScreen(this.selectedTeam, this.rank, {super.key});

  @override
  Widget build(BuildContext context) {
    List<TeamsData> myTeamsData =
        Provider.of<DataProvider>(context).getTeamdata;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        )),
        title: Column(
          children: [
            const SizedBox(
              height: 13,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    width: 64,
                    height: 64,
                    child: Hero(
                        tag: '${selectedTeam - 1}',
                        child: Image.asset(
                            'assets/logos/${selectedTeam - 1}.png'))),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myTeamsData[selectedTeam].teamName,
                      style: const TextStyle(
                          fontSize: 20, height: 0.9, letterSpacing: 0.7),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      " League Rank #${rank + 1}",
                      style: const TextStyle(
                          fontSize: 12,
                          height: 0.9,
                          letterSpacing: 0.7,
                          color: Color.fromARGB(255, 206, 206, 206)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        backgroundColor: myTeamsData[selectedTeam].teamColor,
        bottom: const TabBar(
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(text: 'Stats'),
            Tab(text: 'Squad'),
          ],
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: TabBarView(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: MyStats(selectedTeam, rank)),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: MySquadList(selectedTeam)),
          ],
        ),
      ),
    );
  }
}
