import 'package:flutter/material.dart';

import '../Helpers/db_helper.dart';
import '../models/matchesModal.dart';
import '../models/squadmodal.dart';
import '../models/stadiummodal.dart';
import '../models/teamsModal.dart';
import '../widgets/calculateData.dart';

class DataProvider with ChangeNotifier {
  List<TeamsData> _list = [];

  List<Stadiums> _myStadium = [];

  List<Squad> _SquadList = [];

  List<MatchData> _matchList = [];

  List<TeamsData> get getTeamdata {
    return [..._list];
  }

  List<MatchData> get getmatchData {
    return [..._matchList];
  }

  List<Stadiums> get getStadiumData {
    return [..._myStadium];
  }

  List<Squad> get getSquadData {
    return [..._SquadList];
  }

  Color hexToArgbColor(String hexColor) {
    // Remove the '#' character if it exists
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    // Parse the hexadecimal color string to an integer
    int colorValue = int.parse(hexColor, radix: 16);

    // Add the alpha value (0xFF) to the color value
    int argbColor = 0xFF000000 + colorValue;

    // Return the Color object
    return Color(argbColor);
  }

  Future<void> fetchAndGetTeamData() async {
    final dataList = await DBHelper().getData(
      'teams',
    );
    _list = dataList
        .map(
          (item) => TeamsData(
            item['team_id'],
            item['team_name'],
            item['team_logo'],
            hexToArgbColor(item['team_color']),
            item['abbrevation'],
            item['formation'],
          ),
        )
        .toList();
  }

  Future<void> fetchAndGetMatchData() async {
    final dataList = await DBHelper().getData(
      'matches',
    );
    _matchList = dataList
        .map(
          (item) => MatchData(
            matchId: item['match_id'],
            completed: item['did_played'],
            homeTeamId: item['home_team_id'],
            awayTeamId: item['away_team_id'],
            matchStadiumId: item['stadium_id'],
            homeTeamGoals: item['home_team_goal'],
            awayTeamGoals: item['away_team_goal'],
          ),
        )
        .toList();
  }

  Future<void> fetchAndGetStadiumData() async {
    final dataList = await DBHelper().getData(
      'stadiums',
    );
    _myStadium = dataList
        .map(
          (item) => Stadiums(
            item['stadium_id'],
            item['team_id'],
            item['stadium_name'],
          ),
        )
        .toList();
  }

  Future<void> fetchAndGetPlayersData() async {
    final dataList = await DBHelper().getData(
      'players',
    );
    _SquadList = dataList
        .map(
          (item) => Squad(
            item['team_id'],
            item['player_id'],
            item['player_name'],
            item['player_position'],
          ),
        )
        .toList();
  }

  Future<void> addFixture(MatchData newMAtchData) async {
    await DBHelper().addfixture(newMAtchData);
    _matchList.insert(_matchList.length, newMAtchData);
    calculate(_list, _matchList, true);

    notifyListeners();
  }

  Future<void> updateFixture(MatchData newMAtchData) async {
    await DBHelper().updatefixture(newMAtchData);
    _matchList.removeAt(newMAtchData.matchId);
    _matchList.insert(newMAtchData.matchId, newMAtchData);
    calculate(_list, _matchList, true);
    notifyListeners();
  }

  Future<void> addPlayer(Squad newPlayer, String table) async {
    await DBHelper().addPlayer(table, newPlayer);
    _SquadList.insert(_SquadList.length, newPlayer);
    notifyListeners();
  }

  Future<void> deletePlayer(int playerId, String table) async {
    await DBHelper().deletePlayer(table, playerId);
    final int playerIndex =
        _SquadList.indexWhere((element) => element.playerId == playerId);
    _SquadList.removeAt(playerIndex);
    notifyListeners();
  }

  List<PointsTable> myPointsTable = [];
  void addDumyData(List<TeamsData> myTeamsData) {
    for (int i = 0; i < myTeamsData.length; i++) {
      myPointsTable.add(
        PointsTable(
          teamId: 0,
          teamName: '',
          teamLogo: '',
          teamColor: Colors.white,
          abbreviation: '',
          played: 0,
          wins: 0,
          loses: 0,
          draws: 0,
          points: 0,
          GF: 0,
          GA: 0,
          GD: 0,
          cleanSheets: 0,
        ),
      );
    }
  }

  List<PointsTable> get getPointsTable {
    //addDumyData(_list);
    //calculate(_list, _matchList);
    return [...myPointsTable];
  }

  void calculate(List<TeamsData> myTeamsData, List<MatchData> myMatchData,
      bool didgenerated) {
    !didgenerated ? addDumyData(myTeamsData) : null;
    for (int i = 0; i < myTeamsData.length; i++) {
      int notCleanSheets = 0;
      myPointsTable[i].teamId = myTeamsData[i].teamId;
      myPointsTable[i].teamName = myTeamsData[i].teamName;
      myPointsTable[i].teamLogo = myTeamsData[i].teamLogo;
      myPointsTable[i].teamColor = myTeamsData[i].teamColor;
      myPointsTable[i].abbreviation = myTeamsData[i].abbreviation;
      myPointsTable[i].played = 0;
      myPointsTable[i].GA = 0;
      myPointsTable[i].GD = 0;
      myPointsTable[i].GF = 0;
      myPointsTable[i].wins = 0;
      myPointsTable[i].loses = 0;
      myPointsTable[i].draws = 0;
      myPointsTable[i].points = 0;
      for (int j = 0; j < myMatchData.length; j++) {
        if (myMatchData[j].completed == 1) {
          if (myPointsTable[i].teamId == myMatchData[j].homeTeamId) {
            myPointsTable[i].played++;
            if (myMatchData[j].awayTeamGoals > 0) {
              notCleanSheets++;
            }
            myPointsTable[i].GF =
                myPointsTable[i].GF + myMatchData[j].homeTeamGoals;
            myPointsTable[i].GA =
                myPointsTable[i].GA + myMatchData[j].awayTeamGoals;
            if (myMatchData[j].homeTeamGoals > myMatchData[j].awayTeamGoals) {
              myPointsTable[i].wins++;
              myPointsTable[i].points = myPointsTable[i].points + 3;
            } else if (myMatchData[j].homeTeamGoals <
                myMatchData[j].awayTeamGoals) {
              myPointsTable[i].loses++;
            } else {
              myPointsTable[i].draws++;
              myPointsTable[i].points++;
            }
          } else if (myPointsTable[i].teamId == myMatchData[j].awayTeamId) {
            myPointsTable[i].played++;
            if (myMatchData[j].homeTeamGoals > 0) {
              notCleanSheets++;
            }
            myPointsTable[i].GF =
                myPointsTable[i].GF + myMatchData[j].awayTeamGoals;
            myPointsTable[i].GA =
                myPointsTable[i].GA + myMatchData[j].homeTeamGoals;
            if (myMatchData[j].awayTeamGoals > myMatchData[j].homeTeamGoals) {
              myPointsTable[i].wins++;
              myPointsTable[i].points = myPointsTable[i].points + 3;
            } else if (myMatchData[j].awayTeamGoals <
                myMatchData[j].homeTeamGoals) {
              myPointsTable[i].loses++;
            } else {
              myPointsTable[i].draws++;
              myPointsTable[i].points++;
            }
          }
        }
      }
      myPointsTable[i].cleanSheets = myPointsTable[i].played - notCleanSheets;
      myPointsTable[i].GD = myPointsTable[i].GF - myPointsTable[i].GA;
    }
    myPointsTable.sort((b, a) => a.GF.compareTo(b.GF));
    myPointsTable.sort((b, a) => a.GD.compareTo(b.GD));
    myPointsTable.sort((b, a) => a.points.compareTo(b.points));
  }
}
