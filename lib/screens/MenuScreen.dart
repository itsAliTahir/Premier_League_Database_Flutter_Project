import 'package:flutter/material.dart';
import '../widgets/pointsTable.dart';
import '../widgets/fixtures.dart';
import '../widgets/teamStats.dart';

class MyPointsTableScreen extends StatefulWidget {
  const MyPointsTableScreen({super.key});

  @override
  State<MyPointsTableScreen> createState() => _MyPointsTableScreenState();
}

class _MyPointsTableScreenState extends State<MyPointsTableScreen> {
  @override
  Widget build(BuildContext context) {
    TabController _tabController;

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
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 74,
                      height: 74,
                      child: Image.asset('assets/logos/PL-Main.png')),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Premier\nLeague",
                    style: TextStyle(
                        fontSize: 24, height: 0.9, letterSpacing: 0.7),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: const Color.fromRGBO(57, 0, 61, 1),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: 'Points Table'),
              Tab(text: 'Fixtures'),
              Tab(text: 'Team Stats'),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const MyPointsTable()),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: MyFixtures()),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const MyTeamStats()),
            ],
          ),
        ));
  }
}
