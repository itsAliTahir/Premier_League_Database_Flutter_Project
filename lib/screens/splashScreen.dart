import 'package:dbsproject/Provider/dataprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/matchesModal.dart';
import '../models/teamsModal.dart';
import '../widgets/calculateData.dart';
import 'MenuScreen.dart';

class MySplash extends StatefulWidget {
  const MySplash();

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Provider.of<DataProvider>(context, listen: false)
        .fetchAndGetMatchData();
    await Provider.of<DataProvider>(context, listen: false)
        .fetchAndGetPlayersData();
    await Provider.of<DataProvider>(context, listen: false)
        .fetchAndGetStadiumData();
    await Provider.of<DataProvider>(context, listen: false)
        .fetchAndGetTeamData();
    List<TeamsData> providedTeasms =
        Provider.of<DataProvider>(context, listen: false).getTeamdata;
    List<MatchData> providedMatchData =
        Provider.of<DataProvider>(context, listen: false).getmatchData;
    Provider.of<DataProvider>(context, listen: false)
        .calculate(providedTeasms, providedMatchData, false);

    Future.delayed(Duration(
      seconds: 1,
    )).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => DefaultTabController(
          length: 3, // Number of tabs
          child: MyPointsTableScreen(),
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(148, 0, 158, 1),
              Color.fromRGBO(57, 0, 61, 1),
            ])),
        child: Center(
          child: Center(
            child: Image.asset(
              'assets/logos/PL-Black.png',
              scale: 6,
            ),
          ),
        ),
      ),
    );
  }
}
